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

extension IEEE_1003.UtilitySyntax {
    /// The 14 numbered POSIX 12.2 Utility Syntax Guidelines.
    ///
    /// Each sub-namespace `G{n}` mirrors POSIX 12.2's "Guideline {n}"
    /// verbatim per [API-NAME-003] spec-mirroring. The G{n} identifiers
    /// would otherwise trip `Lint.Rule.Naming.CompoundType` (letter+digit
    /// boundary); each declaration site carries a `// swiftlint:disable:next
    /// type_name` directive with a `reason:` field citing the spec section,
    /// per [RULE-EXEMPT-spec-mirror].
    ///
    /// ## Load-bearing for tokenization
    ///
    /// G3, G4, G5, G6, G7, G9, G10 directly drive ``Tokenizer`` behavior.
    /// Their `validate` static methods may be invoked from the tokenizer
    /// implementation or from L3 consumers wanting to apply guideline-level
    /// validation independently of the full tokenizer pass.
    ///
    /// ## Documentation-only
    ///
    /// G1, G2, G8, G11, G12, G13, G14 are POSIX 12.2 conventions that
    /// constrain utility *behavior* rather than argv tokenization. They
    /// are declared here as namespace placeholders with `description` for
    /// spec completeness; v1 ships no enforcement logic for them.
    ///
    /// ## Reference
    ///
    /// - IEEE Std 1003.1-2017 §12.2 Utility Syntax Guidelines.
    /// - https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap12.html
    public enum Guideline {}
}
