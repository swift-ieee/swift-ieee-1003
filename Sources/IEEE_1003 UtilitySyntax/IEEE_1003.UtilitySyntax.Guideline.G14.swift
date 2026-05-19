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

// `G14` mirrors POSIX 12.2 §12 numbered guideline "Guideline 14" verbatim
// per [API-NAME-003] spec-mirroring exception + [RULE-EXEMPT-spec-mirror].
// swiftlint:disable type_name

extension IEEE_1003.UtilitySyntax.Guideline {
    /// POSIX 12.2 Guideline 14 — option-argument values.
    ///
    /// Spec text: "If there is no operand to represent standard input or
    /// standard output, the standard input or standard output should be
    /// implied as a default when no operand is given."
    ///
    /// Documentation-only; not enforced by ``IEEE_1003/UtilitySyntax/Tokenizer``.
    public enum G14 {
        /// The verbatim spec text for Guideline 14.
        public static let description: Swift.String =
            "If there is no operand to represent standard input or standard output, the standard input or standard output should be implied as a default when no operand is given."
    }
}

// swiftlint:enable type_name
