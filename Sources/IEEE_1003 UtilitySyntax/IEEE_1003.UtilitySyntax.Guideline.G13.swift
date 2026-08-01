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

// `G13` mirrors POSIX 12.2 §12 numbered guideline "Guideline 13" verbatim
// per [API-NAME-003] spec-mirroring exception + [RULE-EXEMPT-spec-mirror].
// swiftlint:disable type_name

extension IEEE_1003.UtilitySyntax.Guideline {
    /// POSIX 12.2 Guideline 13 — standard-input operand.
    ///
    /// Spec text: "For utilities that use operands to represent files to be
    /// opened for either reading or writing, the '-' operand should be used
    /// to mean only standard input (or standard output when it is clear from
    /// context that an output file is being specified) or a file named '-'."
    ///
    /// Documentation-only; not enforced by ``IEEE_1003/UtilitySyntax/Tokenizer``.
    /// The tokenizer classifies a bare `-` argv element as `.operand("-")`;
    /// the convention that this means standard input is the utility's
    /// concern, surfaced at L3.
    public enum G13 {}
}

extension IEEE_1003.UtilitySyntax.Guideline.G13 {
    /// The verbatim spec text for Guideline 13.
    public static let description: Swift.String =
        "For utilities that use operands to represent files to be opened for either reading or writing, the '-' operand should be used to mean only standard input (or standard output when it is clear from context that an output file is being specified) or a file named '-'."
}

// swiftlint:enable type_name
