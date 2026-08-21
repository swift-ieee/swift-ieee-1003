extension IEEE_1003.UtilitySyntax.Token {

    public enum Kind: Sendable, Hashable, Equatable {

        case shortFlag(Swift.Character)

        case shortValue(Swift.String)

        case shortCluster(Swift.String)

        case operand(Swift.String)

        case endOfOptions
    }
}
