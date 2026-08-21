extension IEEE_1003.UtilitySyntax {

    public enum Error: Swift.Error, Sendable, Hashable, Equatable {

        case invalidShortFlagCharacter(
            found: Swift.Character,
            argvIndex: Swift.Int,
            byteOffset: Swift.Int
        )

        case leadingDashWithoutFlag(argvIndex: Swift.Int)

        case emptyArgvElement(argvIndex: Swift.Int)
    }
}
