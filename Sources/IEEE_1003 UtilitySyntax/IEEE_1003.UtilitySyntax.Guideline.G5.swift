extension IEEE_1003.UtilitySyntax.Guideline {

    public enum G5 {}
}

extension IEEE_1003.UtilitySyntax.Guideline.G5 {

    public static let description: Swift.String =
        "One or more options without option-arguments, followed by at most one option that takes an option-argument, should be accepted when grouped behind one '-' delimiter."

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
