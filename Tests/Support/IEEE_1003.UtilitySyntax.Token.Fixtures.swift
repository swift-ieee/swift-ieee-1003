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

extension IEEE_1003.UtilitySyntax.Token {
    /// A test fixture: a `Token` constructed with a zero-byte range.
    ///
    /// Useful for kind-only equality assertions where the byte-range
    /// provenance is not the property under test. Test files asserting
    /// the full token stream should use this helper to avoid threading
    /// per-element byte offsets through fixture literals.
    ///
    /// ## Example
    ///
    /// ```swift
    /// #expect(tokens.map(\.kind) == [.shortFlag("f"), .operand("path")])
    /// ```
    ///
    /// or for kind-equivalent comparison:
    ///
    /// ```swift
    /// let expected: [IEEE_1003.UtilitySyntax.Token] = [
    ///     .fixture(.shortFlag("f")),
    ///     .fixture(.operand("path")),
    /// ]
    /// #expect(tokens.map(\.kind) == expected.map(\.kind))
    /// ```
    public static func fixture(_ kind: IEEE_1003.UtilitySyntax.Token.Kind) -> Self {
        let zero = Text.Position(_unchecked: Ordinal.zero)
        return Self(kind: kind, range: Text.Range(start: zero, end: zero))
    }
}
