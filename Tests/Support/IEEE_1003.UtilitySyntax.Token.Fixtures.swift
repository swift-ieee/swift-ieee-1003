extension IEEE_1003.UtilitySyntax.Token {

    public static func fixture(_ kind: IEEE_1003.UtilitySyntax.Token.Kind) -> Self {
        let zero = Text.Position(_unchecked: Ordinal.zero)
        return Self(kind: kind, range: Text.Range(start: zero, end: zero))
    }
}
