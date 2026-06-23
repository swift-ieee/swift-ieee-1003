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

internal import Argument_Primitives
public import Text_Primitives

extension IEEE_1003.UtilitySyntax {
    /// An L2 intermediate token emitted by ``Tokenizer`` while applying
    /// the POSIX 12.2 utility-syntax guidelines to an argv stream.
    ///
    /// `IEEE_1003.UtilitySyntax.Token` is distinct from L1's
    /// `Argument.Token`: this type carries the POSIX 12.2 classification
    /// (short-flag character, short-flag value, short-flag cluster,
    /// operand, end-of-options separator), while `Argument.Token` is
    /// the cross-tokenizer post-normalization view consumed by L3's
    /// `swift-arguments`. L3 maps `IEEE_1003.UtilitySyntax.Token` to
    /// `Argument.Token` when composing the full argv pipeline.
    ///
    /// ## Range semantics
    ///
    /// `range` is a `Text.Range` over the argv text (the concatenated
    /// argv-element bytes from argv-index 0). When an argv element is
    /// split into multiple tokens (e.g., `-fvalue` → `.shortFlag('f')`
    /// + `.shortValue("value")`), each token carries a sub-range of the
    /// originating argv element's bytes.
    ///
    /// - SeeAlso: `IEEE_1003.UtilitySyntax.Token.Kind`
    /// - SeeAlso: `Argument.Token` (L1, the cross-tokenizer post-normalization view)
    public struct Token: Sendable, Hashable, Equatable {
        /// The semantic kind of this token.
        public let kind: IEEE_1003.UtilitySyntax.Token.Kind

        /// The byte range in the argv source.
        public let range: Text.Range

        /// Creates an L2 token with the given kind and source range.
        @inlinable
        public init(kind: IEEE_1003.UtilitySyntax.Token.Kind, range: Text.Range) {
            self.kind = kind
            self.range = range
        }
    }
}
