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

// `G5` mirrors POSIX 12.2 §12 numbered guideline "Guideline 5" verbatim
// per [API-NAME-003] spec-mirroring exception + [RULE-EXEMPT-spec-mirror].
// swiftlint:disable type_name

extension IEEE_1003.UtilitySyntax.Guideline {
    /// POSIX 12.2 Guideline 5 — option clustering.
    ///
    /// Spec text: "One or more options without option-arguments, followed
    /// by at most one option that takes an option-argument, should be
    /// accepted when grouped behind one '-' delimiter."
    ///
    /// Load-bearing for tokenization: ``IEEE_1003/UtilitySyntax/Tokenizer``
    /// recognizes `-abc` as a cluster of short flags `a`, `b`, `c` (or as
    /// `a` followed by `bc` as an option-argument, when `a` is known to
    /// take a value — but this classification is L3's concern; L2 emits
    /// the cluster form and lets L3 disambiguate).
    public enum G5 {
        /// The verbatim spec text for Guideline 5.
        public static let description: Swift.String =
            "One or more options without option-arguments, followed by at most one option that takes an option-argument, should be accepted when grouped behind one '-' delimiter."

        /// Tests whether the given argv element after the leading `-` is a
        /// valid cluster of short-option characters per Guideline 3 + 5.
        ///
        /// A cluster is a non-empty sequence of ASCII alphanumeric characters.
        ///
        /// - Parameter afterDash: The argv-element substring after the leading `-`.
        /// - Returns: `true` if every character is a valid short-option character;
        ///   `false` otherwise.
        @inlinable
        public static func isValidCluster<S: Swift.StringProtocol>(_ afterDash: S) -> Swift.Bool {
            guard !afterDash.isEmpty else { return false }
            for character in afterDash {
                guard IEEE_1003.UtilitySyntax.Guideline.G3.isValid(character) else {
                    return false
                }
            }
            return true
        }
    }
}

// swiftlint:enable type_name
