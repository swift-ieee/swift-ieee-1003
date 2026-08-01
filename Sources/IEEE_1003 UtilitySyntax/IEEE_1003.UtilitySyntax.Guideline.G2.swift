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

// `G2` mirrors POSIX 12.2 §12 numbered guideline "Guideline 2" verbatim
// per [API-NAME-003] spec-mirroring exception + [RULE-EXEMPT-spec-mirror].
// swiftlint:disable type_name

extension IEEE_1003.UtilitySyntax.Guideline {
    /// POSIX 12.2 Guideline 2 — utility-name character set.
    ///
    /// Spec text: "Utility names should include lowercase letters (the
    /// lower character classification) and digits only from the portable
    /// character set."
    ///
    /// Documentation-only; not enforced by ``IEEE_1003/UtilitySyntax/Tokenizer``.
    public enum G2 {}
}

extension IEEE_1003.UtilitySyntax.Guideline.G2 {
    /// The verbatim spec text for Guideline 2.
    public static let description: Swift.String =
        "Utility names should include lowercase letters and digits only from the portable character set."
}

// swiftlint:enable type_name
