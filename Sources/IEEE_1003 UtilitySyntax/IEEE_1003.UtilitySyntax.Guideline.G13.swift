extension IEEE_1003.UtilitySyntax.Guideline {

    public enum G13 {}
}

extension IEEE_1003.UtilitySyntax.Guideline.G13 {

    public static let description: Swift.String =
        "For utilities that use operands to represent files to be opened for either reading or writing, the '-' operand should be used to mean only standard input (or standard output when it is clear from context that an output file is being specified) or a file named '-'."
}
