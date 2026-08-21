extension IEEE_1003.UtilitySyntax.Guideline {

    public enum G4 {}
}

extension IEEE_1003.UtilitySyntax.Guideline.G4 {

    public static let description: Swift.String =
        "All options should be preceded by the '-' delimiter character."

    @inlinable
    public static func isOptionShaped(_ element: Swift.String) -> Swift.Bool {
        guard element.hasPrefix("-") else { return false }
        guard element.count > 1 else { return false }
        guard element != "--" else { return false }
        return true
    }
}
