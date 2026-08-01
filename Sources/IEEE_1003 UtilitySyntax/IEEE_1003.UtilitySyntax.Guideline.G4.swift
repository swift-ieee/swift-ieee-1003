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

// `G4` mirrors POSIX 12.2 §12 numbered guideline "Guideline 4" verbatim
// per [API-NAME-003] spec-mirroring exception + [RULE-EXEMPT-spec-mirror].
// swiftlint:disable type_name

extension IEEE_1003.UtilitySyntax.Guideline {
    /// POSIX 12.2 Guideline 4 — options preceded by `-`.
    ///
    /// Spec text: "All options should be preceded by the '-' delimiter
    /// character."
    ///
    /// Load-bearing for tokenization: ``IEEE_1003/UtilitySyntax/Tokenizer``
    /// recognizes option elements by their leading `-` and classifies all
    /// other elements as operands.
    public enum G4 {}
}

extension IEEE_1003.UtilitySyntax.Guideline.G4 {
    /// The verbatim spec text for Guideline 4.
    public static let description: Swift.String =
        "All options should be preceded by the '-' delimiter character."

    /// Tests whether the given argv element is shaped like an option
    /// per Guideline 4: starts with `-` and has at least one character
    /// after the dash.
    ///
    /// Returns `false` for bare `-` (Guideline 4 declares a leading
    /// `-` is the option marker, but a lone `-` is conventionally
    /// treated as an operand referring to standard input).
    ///
    /// Returns `false` for `--` (the end-of-options separator per
    /// Guideline 10).
    ///
    /// - Parameter element: The argv element to classify.
    /// - Returns: `true` if the element is option-shaped; `false` otherwise.
    @inlinable
    public static func isOptionShaped(_ element: Swift.String) -> Swift.Bool {
        guard element.hasPrefix("-") else { return false }
        guard element.count > 1 else { return false }  // bare "-"
        guard element != "--" else { return false }  // end-of-options
        return true
    }
}

// swiftlint:enable type_name
