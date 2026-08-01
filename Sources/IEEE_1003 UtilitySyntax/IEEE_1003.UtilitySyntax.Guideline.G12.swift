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

// `G12` mirrors POSIX 12.2 §12 numbered guideline "Guideline 12" verbatim
// per [API-NAME-003] spec-mirroring exception + [RULE-EXEMPT-spec-mirror].
// swiftlint:disable type_name

extension IEEE_1003.UtilitySyntax.Guideline {
    /// POSIX 12.2 Guideline 12 — operand-order independence.
    ///
    /// Spec text: "The order of operands may matter and position-related
    /// interpretations should be determined on a utility-specific basis."
    ///
    /// Documentation-only; not enforced by ``IEEE_1003/UtilitySyntax/Tokenizer``.
    public enum G12 {}
}

extension IEEE_1003.UtilitySyntax.Guideline.G12 {
    /// The verbatim spec text for Guideline 12.
    public static let description: Swift.String =
        "The order of operands may matter and position-related interpretations should be determined on a utility-specific basis."
}

// swiftlint:enable type_name
