extension IEEE_1003.UtilitySyntax.Guideline {

    public enum G3 {}
}

extension IEEE_1003.UtilitySyntax.Guideline.G3 {

    public static let description: Swift.String =
        "Each option name should be a single alphanumeric character (the alnum character classification) from the portable character set."

    @inlinable
    public static func isValid(_ character: Swift.Character) -> Swift.Bool {
        character.isASCII && (character.isLetter || character.isNumber)
    }
}
