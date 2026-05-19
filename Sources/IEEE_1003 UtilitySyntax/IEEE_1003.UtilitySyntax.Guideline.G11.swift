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

// `G11` mirrors POSIX 12.2 §12 numbered guideline "Guideline 11" verbatim
// per [API-NAME-003] spec-mirroring exception + [RULE-EXEMPT-spec-mirror].
// swiftlint:disable type_name

extension IEEE_1003.UtilitySyntax.Guideline {
    /// POSIX 12.2 Guideline 11 — operand order.
    ///
    /// Spec text: "The order of different options relative to one another
    /// should not matter, unless the options are documented as mutually-
    /// exclusive and such an option is documented to override any incompatible
    /// options preceding it. If an option that has option-arguments is
    /// repeated, the option and option-argument combinations should be
    /// interpreted in the order specified on the command line."
    ///
    /// Documentation-only; not enforced by ``IEEE_1003/UtilitySyntax/Tokenizer``.
    /// Option-order semantics are an L3 concern: the tokenizer emits tokens
    /// in source order, and L3 schema-bound parsers interpret the relative
    /// order per the utility's documented contract.
    public enum G11 {
        /// The verbatim spec text for Guideline 11.
        public static let description: Swift.String =
            "The order of different options relative to one another should not matter, unless the options are documented as mutually-exclusive and such an option is documented to override any incompatible options preceding it. If an option that has option-arguments is repeated, the option and option-argument combinations should be interpreted in the order specified on the command line."
    }
}

// swiftlint:enable type_name
