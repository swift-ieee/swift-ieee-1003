extension IEEE_1003.UtilitySyntax.Token {

    public static func fixture(_ kind: IEEE_1003.UtilitySyntax.Token.Kind) -> Self {
        let zero = Text.Position(_unchecked: Ordinal.zero)
        do throws(Text.Range.Error) {
            return Self(kind: kind, range: try Text.Range(start: zero, end: zero))
        } catch {
            preconditionFailure("An empty range at zero is valid: \(error)")
        }
    }
}
