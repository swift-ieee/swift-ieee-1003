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

// `G8` mirrors POSIX 12.2 §12 numbered guideline "Guideline 8" verbatim
// per [API-NAME-003] spec-mirroring exception + [RULE-EXEMPT-spec-mirror].
// swiftlint:disable type_name

extension IEEE_1003.UtilitySyntax.Guideline {
    /// POSIX 12.2 Guideline 8 — multi-value option-arguments.
    ///
    /// Spec text: "When multiple option-arguments are specified to follow
    /// a single option, they should be presented as a single argument,
    /// using <comma> characters within that argument or <blank>
    /// characters within that argument to separate them."
    ///
    /// Documentation-only; not enforced by ``IEEE_1003/UtilitySyntax/Tokenizer``.
    /// Multi-value parsing is an L3 concern: the tokenizer emits the
    /// raw `.shortValue` string, and L3 schema-bound parsers split it
    /// per the relevant convention.
    public enum G8 {}
}

extension IEEE_1003.UtilitySyntax.Guideline.G8 {
    /// The verbatim spec text for Guideline 8.
    public static let description: Swift.String =
        "When multiple option-arguments are specified to follow a single option, they should be presented as a single argument, using <comma> characters within that argument or <blank> characters within that argument to separate them."
}

// swiftlint:enable type_name
