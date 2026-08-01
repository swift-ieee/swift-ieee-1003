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

// `G9` mirrors POSIX 12.2 §12 numbered guideline "Guideline 9" verbatim
// per [API-NAME-003] spec-mirroring exception + [RULE-EXEMPT-spec-mirror].
// swiftlint:disable type_name

extension IEEE_1003.UtilitySyntax.Guideline {
    /// POSIX 12.2 Guideline 9 — option order.
    ///
    /// Spec text: "All options should precede operands on the command line."
    ///
    /// Load-bearing for tokenization in the sense that the tokenizer's
    /// default behavior follows option-then-operand classification: once
    /// the first non-option element is encountered (or `--`), subsequent
    /// elements are operands. L3 schema layers may override this for
    /// utilities accepting interleaved options + operands (a GNU extension,
    /// not strict POSIX 12.2), but the L2 tokenizer reflects the strict
    /// POSIX 12.2 ordering by default.
    public enum G9 {}
}

extension IEEE_1003.UtilitySyntax.Guideline.G9 {
    /// The verbatim spec text for Guideline 9.
    public static let description: Swift.String =
        "All options should precede operands on the command line."
}

// swiftlint:enable type_name
