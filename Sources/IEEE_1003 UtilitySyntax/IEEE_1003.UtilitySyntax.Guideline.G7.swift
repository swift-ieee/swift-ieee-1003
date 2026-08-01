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

// `G7` mirrors POSIX 12.2 §12 numbered guideline "Guideline 7" verbatim
// per [API-NAME-003] spec-mirroring exception + [RULE-EXEMPT-spec-mirror].
// swiftlint:disable type_name

extension IEEE_1003.UtilitySyntax.Guideline {
    /// POSIX 12.2 Guideline 7 — option-argument shape.
    ///
    /// Spec text: "Option-arguments should not be optional."
    ///
    /// Load-bearing for tokenization in the sense that the tokenizer's
    /// disambiguation of `-fvalue` (short flag `f` plus value `value`)
    /// vs. `-f -v -a -l -u -e` (cluster of six short flags) requires
    /// L3 schema knowledge of which flags take arguments. L2 emits both
    /// the `.shortCluster` and (separately, via Guideline 6 handling)
    /// the `.shortFlag + .shortValue` form, leaving the resolution to
    /// L3.
    public enum G7 {}
}

extension IEEE_1003.UtilitySyntax.Guideline.G7 {
    /// The verbatim spec text for Guideline 7.
    public static let description: Swift.String =
        "Option-arguments should not be optional."
}

// swiftlint:enable type_name
