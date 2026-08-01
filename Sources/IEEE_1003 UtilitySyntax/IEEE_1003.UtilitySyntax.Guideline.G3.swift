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

// `G3` mirrors POSIX 12.2 §12 numbered guideline "Guideline 3" verbatim
// per [API-NAME-003] spec-mirroring exception + [RULE-EXEMPT-spec-mirror].
// swiftlint:disable type_name

extension IEEE_1003.UtilitySyntax.Guideline {
    /// POSIX 12.2 Guideline 3 — option-name shape.
    ///
    /// Spec text: "Each option name should be a single alphanumeric
    /// character (the alnum character classification) from the portable
    /// character set."
    ///
    /// Load-bearing for tokenization: ``IEEE_1003/UtilitySyntax/Tokenizer``
    /// rejects argv elements whose option-name character is not a single
    /// ASCII alphanumeric.
    public enum G3 {}
}

extension IEEE_1003.UtilitySyntax.Guideline.G3 {
    /// The verbatim spec text for Guideline 3.
    public static let description: Swift.String =
        "Each option name should be a single alphanumeric character (the alnum character classification) from the portable character set."

    /// Validates that the given character is a single ASCII alphanumeric
    /// per Guideline 3.
    ///
    /// - Parameter character: The candidate option-name character.
    /// - Returns: `true` if the character is a single ASCII alphanumeric;
    ///   `false` otherwise.
    @inlinable
    public static func isValid(_ character: Swift.Character) -> Swift.Bool {
        character.isASCII && (character.isLetter || character.isNumber)
    }
}

// swiftlint:enable type_name
