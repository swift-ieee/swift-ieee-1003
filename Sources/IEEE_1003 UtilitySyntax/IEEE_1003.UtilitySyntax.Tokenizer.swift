// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-ieee-1003 open source project
//
// Copyright (c) 2026 Coen ten Thije Boonkkamp and the swift-ieee-1003 project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

internal import Argument_Primitives
public import Parser_Primitives
internal import Text_Primitives
internal import Index_Primitives

extension IEEE_1003.UtilitySyntax {
    /// A POSIX 12.2 utility-syntax tokenizer.
    ///
    /// `Tokenizer` consumes a `[Swift.String]` argv (as produced by
    /// `Swift.CommandLine.arguments` minus its program-name prefix) and
    /// emits a `[IEEE_1003.UtilitySyntax.Token]` stream classified per
    /// POSIX 12.2 Utility Syntax Guidelines 3, 4, 5, 6, 7, 9, and 10.
    ///
    /// ## Classification policy
    ///
    /// - `--` is emitted as ``Token/Kind/endOfOptions`` (Guideline 10);
    ///   subsequent argv elements emit ``Token/Kind/operand`` regardless
    ///   of leading dashes.
    /// - A bare `-` is emitted as ``Token/Kind/operand`` (Guideline 13:
    ///   conventional standard-input marker; L3 may reinterpret).
    /// - `-f` (single character following the dash) emits
    ///   ``Token/Kind/shortFlag`` for that character (Guidelines 3 + 4).
    /// - `-fvalue` (multiple characters following the dash) emits
    ///   ``Token/Kind/shortFlag`` for the first character followed by
    ///   ``Token/Kind/shortValue`` for the remainder. This is the
    ///   Guideline-6 concatenated option-argument form. L3 disambiguates
    ///   whether the trailing text is a value or a continued cluster
    ///   based on schema.
    /// - Non-option-shaped argv elements emit ``Token/Kind/operand``
    ///   (Guideline 9 ordering applies only after the first operand or
    ///   `--`; L3 may relax this).
    ///
    /// ## Cluster vs. concatenated-value
    ///
    /// Per the design note in the swift-arguments ecosystem design v1.0.7,
    /// the tokenizer emits the Guideline-6 form (`.shortFlag` + `.shortValue`)
    /// for any `-xYYY` where `YYY` is non-empty. The Guideline-5 cluster
    /// form (`-abc` as three flags) is represented as a separate
    /// ``Token/Kind/shortCluster`` token; the tokenizer emits it when the
    /// argv element matches the cluster pattern (every character after
    /// the leading dash is a valid Guideline-3 character). When both
    /// classifications apply (e.g., `-abc` could be a cluster `a,b,c` or
    /// a short flag `a` with value `bc`), the tokenizer emits the
    /// `shortFlag + shortValue` Guideline-6 form by default; L3 schema-aware
    /// re-classification yields the cluster form when appropriate.
    ///
    /// This v1 default favors Guideline 6 over Guideline 5 because most
    /// real-world utilities have a small minority of cluster-only flags
    /// and a majority of value-taking options, so the Guideline-6 default
    /// minimizes per-flag re-tokenization at L3. Strict-cluster utilities
    /// can post-process the emitted tokens.
    ///
    /// ## Parser.Protocol conformance
    ///
    /// `Tokenizer` is a leaf parser (``Body`` is `Never`). The
    /// ``parse(_:)`` method consumes the full input `[Swift.String]`
    /// at once and emits `[Token]`. After a successful parse, `input`
    /// is empty.
    public struct Tokenizer: Parser.`Protocol` {
        public typealias Input = [Swift.String]
        public typealias Output = [IEEE_1003.UtilitySyntax.Token]
        public typealias Failure = IEEE_1003.UtilitySyntax.Error
        public typealias Body = Never

        /// Creates a tokenizer with default policy.
        @inlinable
        public init() {}

        /// Tokenizes the argv `[String]` per POSIX 12.2 §12.2.
        ///
        /// Consumes `input` entirely; on a successful parse, `input` is
        /// empty.
        ///
        /// - Parameter input: A mutable argv `[String]` reference.
        /// - Returns: The classified token stream.
        /// - Throws: ``IEEE_1003/UtilitySyntax/Error`` if an argv element
        ///   violates a load-bearing guideline (e.g., Guideline 3 ASCII
        ///   alphanumeric short-flag character).
        public borrowing func parse(
            _ input: inout [Swift.String]
        ) throws(IEEE_1003.UtilitySyntax.Error) -> [IEEE_1003.UtilitySyntax.Token] {
            var tokens: [IEEE_1003.UtilitySyntax.Token] = []
            var byteOffset: Swift.UInt = 0
            var afterEndOfOptions = false
            var argvIndex: Swift.Int = 0

            while !input.isEmpty {
                let element = input.removeFirst()
                defer { argvIndex &+= 1 }

                let elementByteCount = Swift.UInt(element.utf8.count)
                let elementStart = Text.Position(_unchecked: Ordinal(byteOffset))
                let elementEnd = Text.Position(_unchecked: Ordinal(byteOffset &+ elementByteCount))
                let elementRange = Text.Range(start: elementStart, end: elementEnd)
                defer { byteOffset &+= elementByteCount }

                // After --, every element is an operand.
                if afterEndOfOptions {
                    tokens.append(.init(kind: .operand(element), range: elementRange))
                    continue
                }

                // -- separator (Guideline 10).
                if IEEE_1003.UtilitySyntax.Guideline.G10.isEndOfOptions(element) {
                    tokens.append(.init(kind: .endOfOptions, range: elementRange))
                    afterEndOfOptions = true
                    continue
                }

                // Non-option-shaped elements are operands (Guideline 4 inverse).
                guard IEEE_1003.UtilitySyntax.Guideline.G4.isOptionShaped(element) else {
                    tokens.append(.init(kind: .operand(element), range: elementRange))
                    continue
                }

                // Option-shaped: strip leading dash; classify the remainder.
                // element.count > 1 is guaranteed by G4.isOptionShaped.
                let afterDash = element.dropFirst()
                // afterDash is non-empty because element.count > 1.
                // Validate the first character per G3.
                guard let firstChar = afterDash.first else {
                    // Defensive: should be unreachable under G4.isOptionShaped.
                    throw .leadingDashWithoutFlag(argvIndex: argvIndex)
                }
                guard IEEE_1003.UtilitySyntax.Guideline.G3.isValid(firstChar) else {
                    // Byte offset of the offending character: leading dash is 1 byte.
                    throw .invalidShortFlagCharacter(
                        found: firstChar,
                        argvIndex: argvIndex,
                        byteOffset: 1
                    )
                }

                // Compute the byte-range of the flag character (after the dash).
                // Single-character flags use 1 byte for the dash and N bytes for the char.
                let firstCharByteCount = Swift.UInt(firstChar.utf8.count)
                let flagStart = Text.Position(_unchecked: Ordinal(byteOffset &+ 1))
                let flagEnd = Text.Position(
                    _unchecked: Ordinal(byteOffset &+ 1 &+ firstCharByteCount)
                )
                let flagRange = Text.Range(start: flagStart, end: flagEnd)

                // Single-character flag: -f
                if afterDash.count == 1 {
                    tokens.append(.init(kind: .shortFlag(firstChar), range: flagRange))
                    continue
                }

                // Multi-character: -fvalue → .shortFlag('f') + .shortValue("value")
                // (Guideline 6 concatenated form). When the value portion is itself
                // valid as a cluster of Guideline-3 characters, the schema layer at
                // L3 may decide to re-emit as .shortCluster instead.
                tokens.append(.init(kind: .shortFlag(firstChar), range: flagRange))

                let valueString = Swift.String(afterDash.dropFirst())
                let valueStart = flagEnd
                let valueEnd = Text.Position(_unchecked: Ordinal(byteOffset &+ elementByteCount))
                let valueRange = Text.Range(start: valueStart, end: valueEnd)
                tokens.append(.init(kind: .shortValue(valueString), range: valueRange))
            }

            return tokens
        }
    }
}
