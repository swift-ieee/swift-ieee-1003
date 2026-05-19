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

extension IEEE_1003.UtilitySyntax.Token {
    /// The semantic kind of an `IEEE_1003.UtilitySyntax.Token`, as classified
    /// by the POSIX 12.2 utility-syntax guidelines.
    ///
    /// ## Kinds
    ///
    /// - `.shortFlag(c)` — a single short-option character. Per POSIX 12.2
    ///   Guideline 3, `c` is a single ASCII alphanumeric. An argv element
    ///   `-f` is emitted as `.shortFlag("f")`.
    /// - `.shortValue(s)` — a value immediately concatenated to a
    ///   preceding short option, per POSIX 12.2 Guideline 6 (option-arguments
    ///   may be specified in the same argv element). For example, in
    ///   `-fvalue`, the `value` portion is emitted as `.shortValue("value")`
    ///   following a `.shortFlag("f")`.
    /// - `.shortCluster(s)` — a clustered short-option sequence per POSIX
    ///   12.2 Guideline 5. For example, `-abc` (where `a`, `b`, `c` are all
    ///   value-less flags) emits `.shortCluster("abc")`. Whether to emit a
    ///   cluster as one token or as several `.shortFlag` tokens is a
    ///   tokenizer-policy decision; this case captures the unsplit form
    ///   for callers that want to defer the per-character classification
    ///   to L3.
    /// - `.operand(s)` — a non-option argv element (a positional argument).
    ///   For example, the `path` in `cat path`.
    /// - `.endOfOptions` — the `--` separator per POSIX 12.2 Guideline 10.
    ///   All argv elements following this separator are operands regardless
    ///   of leading dashes.
    public enum Kind: Sendable, Hashable, Equatable {
        /// A single short-option character per POSIX 12.2 Guideline 3.
        case shortFlag(Swift.Character)
        /// A value bound to a preceding short option per POSIX 12.2 Guideline 6.
        case shortValue(Swift.String)
        /// A clustered short-option sequence per POSIX 12.2 Guideline 5.
        case shortCluster(Swift.String)
        /// A positional (operand) argument.
        case operand(Swift.String)
        /// The `--` end-of-options separator per POSIX 12.2 Guideline 10.
        case endOfOptions
    }
}
