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

// `G10` mirrors POSIX 12.2 §12 numbered guideline "Guideline 10" verbatim
// per [API-NAME-003] spec-mirroring exception + [RULE-EXEMPT-spec-mirror].
// swiftlint:disable type_name

extension IEEE_1003.UtilitySyntax.Guideline {
    /// POSIX 12.2 Guideline 10 — end-of-options separator.
    ///
    /// Spec text: "The first '--' argument that is not an option-argument
    /// should be accepted as a delimiter indicating the end of options.
    /// Any following arguments should be treated as operands, even if
    /// they begin with the '-' character."
    ///
    /// Load-bearing for tokenization: ``IEEE_1003/UtilitySyntax/Tokenizer``
    /// emits a `.endOfOptions` token when it encounters `--` and treats
    /// every subsequent argv element as `.operand` regardless of leading
    /// dashes.
    public enum G10 {}
}

extension IEEE_1003.UtilitySyntax.Guideline.G10 {
    /// The verbatim spec text for Guideline 10.
    public static let description: Swift.String =
        "The first '--' argument that is not an option-argument should be accepted as a delimiter indicating the end of options. Any following arguments should be treated as operands, even if they begin with the '-' character."

    /// Tests whether the given argv element is the end-of-options separator.
    ///
    /// - Parameter element: The argv element to classify.
    /// - Returns: `true` if the element is exactly `"--"`; `false` otherwise.
    @inlinable
    public static func isEndOfOptions(_ element: Swift.String) -> Swift.Bool {
        element == "--"
    }
}

// swiftlint:enable type_name
