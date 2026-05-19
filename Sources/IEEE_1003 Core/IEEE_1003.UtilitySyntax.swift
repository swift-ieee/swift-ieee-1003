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

extension IEEE_1003 {
    /// IEEE 1003.1-2017 Chapter 12 — Utility Conventions.
    ///
    /// This sub-namespace mirrors the POSIX 12.2 Utility Syntax Guidelines —
    /// the 14 numbered guidelines specifying how command-line utilities accept
    /// argument syntax (`-f`, `-fvalue`, `-abc` clustering, `--` separator,
    /// positional arguments).
    ///
    /// ## Composition at L3
    ///
    /// `swift-arguments` (L3) composes ``Tokenizer`` with its GNU long-option
    /// inline handling. The L2 tokenizer here owns only POSIX 12.2; GNU
    /// long-options are handled inline at L3 per the v1 scope discipline.
    ///
    /// ## Intermediate token type
    ///
    /// The tokenizer emits ``Token`` — an L2 intermediate representation
    /// distinct from L1's `Argument.Token`. L3 (`swift-arguments`) maps
    /// L2 tokens to L1 tokens when composing the full argv pipeline.
    ///
    /// ## Reference
    ///
    /// - IEEE Std 1003.1-2017 §12.2 Utility Syntax Guidelines.
    /// - https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap12.html
    public enum UtilitySyntax {}
}
