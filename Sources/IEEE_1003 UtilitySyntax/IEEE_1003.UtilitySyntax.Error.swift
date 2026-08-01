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

extension IEEE_1003.UtilitySyntax {
    /// Errors produced by ``Tokenizer`` when applying POSIX 12.2 utility-syntax
    /// guidelines to an argv element.
    ///
    /// Each error case names the POSIX 12.2 Guideline it is keyed to, so
    /// downstream diagnostics can cite the spec-text the violation
    /// references.
    ///
    /// ## Cases
    ///
    /// - ``invalidShortFlagCharacter(found:argvIndex:byteOffset:)`` —
    ///   Guideline 3: option names must be a single alphanumeric character.
    /// - ``leadingDashWithoutFlag(argvIndex:)`` —
    ///   Guideline 4: a bare `-` is not a valid option element (callers may
    ///   treat it as an operand, but the tokenizer flags it).
    /// - ``emptyArgvElement(argvIndex:)`` — an empty argv element was
    ///   encountered; not a Guideline-keyed failure, but an argv-shape
    ///   problem the tokenizer cannot proceed past.
    public enum Error: Swift.Error, Sendable, Hashable, Equatable {
        /// A short-option character was not a single ASCII alphanumeric
        /// per POSIX 12.2 Guideline 3.
        case invalidShortFlagCharacter(
            found: Swift.Character,
            argvIndex: Swift.Int,
            byteOffset: Swift.Int
        )

        /// A leading dash was found without a following flag character
        /// per POSIX 12.2 Guideline 4 (a bare `-` is not an option).
        case leadingDashWithoutFlag(argvIndex: Swift.Int)

        /// An empty argv element was encountered. The tokenizer cannot
        /// classify a zero-length string.
        case emptyArgvElement(argvIndex: Swift.Int)
    }
}
