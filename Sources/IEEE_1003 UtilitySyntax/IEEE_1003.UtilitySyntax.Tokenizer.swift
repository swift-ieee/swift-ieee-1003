internal import Argument
internal import Index
public import Parser
internal import Text

extension IEEE_1003.UtilitySyntax {

    public struct Tokenizer: Parsing {
        public var body: Never {
            borrowing get {
                return fatalError("\(Self.self) is a leaf: implement its conformance requirements directly")
            }
        }

        @inlinable
        public init() {}
    }
}

extension IEEE_1003.UtilitySyntax.Tokenizer {
    public typealias Input = [Swift.String]
    public typealias Output = [IEEE_1003.UtilitySyntax.Token]
    public typealias Body = Never

    public borrowing func parse(
        _ input: inout [Swift.String]
    ) throws(IEEE_1003.UtilitySyntax.Error) -> [IEEE_1003.UtilitySyntax.Token] {
        var tokens: [IEEE_1003.UtilitySyntax.Token] = []
        var byteOffset: Swift.UInt = 0
        var afterEndOfOptions = false
        var argvIndex: Swift.Int = 0

        while !input.isEmpty {
            let element = input.removeFirst()
            defer { argvIndex &+= 1 }

            let elementByteCount = Swift.UInt(element.utf8.count)
            let elementStart = Text.Position(_unchecked: Ordinal(byteOffset))
            let elementEnd = Text.Position(_unchecked: Ordinal(byteOffset &+ elementByteCount))
            let elementRange = Text.Range(start: elementStart, end: elementEnd)
            defer { byteOffset &+= elementByteCount }

            if afterEndOfOptions {
                tokens.append(.init(kind: .operand(element), range: elementRange))
                continue
            }

            if IEEE_1003.UtilitySyntax.Guideline.G10.isEndOfOptions(element) {
                tokens.append(.init(kind: .endOfOptions, range: elementRange))
                afterEndOfOptions = true
                continue
            }

            guard IEEE_1003.UtilitySyntax.Guideline.G4.isOptionShaped(element) else {
                tokens.append(.init(kind: .operand(element), range: elementRange))
                continue
            }

            let afterDash = element.dropFirst()

            guard let firstChar = afterDash.first else {

                throw .leadingDashWithoutFlag(argvIndex: argvIndex)
            }
            guard IEEE_1003.UtilitySyntax.Guideline.G3.isValid(firstChar) else {

                throw .invalidShortFlagCharacter(
                    found: firstChar,
                    argvIndex: argvIndex,
                    byteOffset: 1
                )
            }

            let firstCharByteCount = Swift.UInt(firstChar.utf8.count)
            let flagStart = Text.Position(_unchecked: Ordinal(byteOffset &+ 1))
            let flagEnd = Text.Position(
                _unchecked: Ordinal(byteOffset &+ 1 &+ firstCharByteCount)
            )
            let flagRange = Text.Range(start: flagStart, end: flagEnd)

            if afterDash.count == 1 {
                tokens.append(.init(kind: .shortFlag(firstChar), range: flagRange))
                continue
            }

            tokens.append(.init(kind: .shortFlag(firstChar), range: flagRange))

            let valueString = Swift.String(afterDash.dropFirst())
            let valueStart = flagEnd
            let valueEnd = Text.Position(_unchecked: Ordinal(byteOffset &+ elementByteCount))
            let valueRange = Text.Range(start: valueStart, end: valueEnd)
            tokens.append(.init(kind: .shortValue(valueString), range: valueRange))
        }

        return tokens
    }
}
