extension IEEE_1003.UtilitySyntax.Guideline {

    public enum G10 {}
}

extension IEEE_1003.UtilitySyntax.Guideline.G10 {

    public static let description: Swift.String =
        "The first '--' argument that is not an option-argument should be accepted as a delimiter indicating the end of options. Any following arguments should be treated as operands, even if they begin with the '-' character."

    @inlinable
    public static func isEndOfOptions(_ element: Swift.String) -> Swift.Bool {
        element == "--"
    }
}
