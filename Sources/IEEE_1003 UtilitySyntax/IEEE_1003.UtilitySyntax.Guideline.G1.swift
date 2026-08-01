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

// `G1` mirrors POSIX 12.2 §12 numbered guideline "Guideline 1" verbatim
// per [API-NAME-003] spec-mirroring exception + [RULE-EXEMPT-spec-mirror].
// swiftlint:disable type_name

extension IEEE_1003.UtilitySyntax.Guideline {
    /// POSIX 12.2 Guideline 1 — utility-name conventions.
    ///
    /// Spec text: "Utility names should be between two and nine characters,
    /// inclusive."
    ///
    /// Documentation-only; not enforced by ``IEEE_1003/UtilitySyntax/Tokenizer``.
    /// Utility-name constraints are a separate concern from argv tokenization;
    /// L3 consumers MAY apply this constraint to a utility-name string
    /// independently if they wish.
    public enum G1 {}
}

extension IEEE_1003.UtilitySyntax.Guideline.G1 {
    /// The verbatim spec text for Guideline 1.
    public static let description: Swift.String =
        "Utility names should be between two and nine characters, inclusive."
}

// swiftlint:enable type_name
