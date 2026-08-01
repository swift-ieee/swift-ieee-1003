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

// `G6` mirrors POSIX 12.2 §12 numbered guideline "Guideline 6" verbatim
// per [API-NAME-003] spec-mirroring exception + [RULE-EXEMPT-spec-mirror].
// swiftlint:disable type_name

extension IEEE_1003.UtilitySyntax.Guideline {
    /// POSIX 12.2 Guideline 6 — option-argument separation.
    ///
    /// Spec text: "Each option and option-argument should be a separate
    /// argument, except as noted in Utility Argument Syntax, item 5."
    ///
    /// Load-bearing for tokenization: option-arguments may be either
    /// separated (`-f value`) or concatenated (`-fvalue`); both forms
    /// emit a `.shortFlag` followed by a `.shortValue` once tokenization
    /// completes its short-cluster pass.
    public enum G6 {}
}

extension IEEE_1003.UtilitySyntax.Guideline.G6 {
    /// The verbatim spec text for Guideline 6.
    public static let description: Swift.String =
        "Each option and option-argument should be a separate argument, except as noted in Utility Argument Syntax, item 5."
}

// swiftlint:enable type_name
