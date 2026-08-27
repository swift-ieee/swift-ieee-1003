internal import Argument
public import Text

extension IEEE_1003.UtilitySyntax {

    public struct Token: Sendable, Hashable, Equatable {

        public let kind: IEEE_1003.UtilitySyntax.Token.Kind

        public let range: Text.Range

        @inlinable
        public init(kind: IEEE_1003.UtilitySyntax.Token.Kind, range: Text.Range) {
            self.kind = kind
            self.range = range
        }
    }
}
