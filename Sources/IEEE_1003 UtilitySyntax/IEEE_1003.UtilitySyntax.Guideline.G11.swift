extension IEEE_1003.UtilitySyntax.Guideline {

    public enum G11 {}
}

extension IEEE_1003.UtilitySyntax.Guideline.G11 {

    public static let description: Swift.String =
        "The order of different options relative to one another should not matter, unless the options are documented as mutually-exclusive and such an option is documented to override any incompatible options preceding it. If an option that has option-arguments is repeated, the option and option-argument combinations should be interpreted in the order specified on the command line."
}
