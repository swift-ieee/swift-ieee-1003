internal import Argument
internal import Index
public import Parser
internal import Text

extension IEEE_1003.UtilitySyntax {

    public struct Tokenizer: Parsing {

        @inlinable
        public init() {}
    }
}

extension IEEE_1003.UtilitySyntax.Tokenizer {
    public typealias Input = [Swift::String]
    public typealias Output = [IEEE_1003.UtilitySyntax.Token]
    public typealias Body = Never

    public borrowing func parse(
        _ input: inout [Swift::String]
    ) throws(IEEE_1003.UtilitySyntax.Error) -> [IEEE_1003.UtilitySyntax.Token] {
        var tokens: [IEEE_1003.UtilitySyntax.Token] = []
        var byteOffset: Swift::UInt = 0
        var afterEndOfOptions = false
        var argvIndex: Swift::Int = 0

        while !input.isEmpty {
            let element = input.removeFirst()
            defer { argvIndex &+= 1 }

            let elementByteCount = Swift::UInt(element.utf8.count)
            let elementStart = Text.Position(_unchecked: Ordinal(byteOffset))
            let elementEnd = Text.Position(_unchecked: Ordinal(byteOffset &+ elementByteCount))
            let elementRange = Self.range(from: elementStart, to: elementEnd)
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

            let firstCharByteCount = Swift::UInt(firstChar.utf8.count)
            let flagStart = Text.Position(_unchecked: Ordinal(byteOffset &+ 1))
            let flagEnd = Text.Position(
                _unchecked: Ordinal(byteOffset &+ 1 &+ firstCharByteCount)
            )
            let flagRange = Self.range(from: flagStart, to: flagEnd)

            if afterDash.count == 1 {
                tokens.append(.init(kind: .shortFlag(firstChar), range: flagRange))
                continue
            }

            tokens.append(.init(kind: .shortFlag(firstChar), range: flagRange))

            let valueString = Swift::String(afterDash.dropFirst())
            let valueStart = flagEnd
            let valueEnd = Text.Position(_unchecked: Ordinal(byteOffset &+ elementByteCount))
            let valueRange = Self.range(from: valueStart, to: valueEnd)
            tokens.append(.init(kind: .shortValue(valueString), range: valueRange))
        }

        return tokens
    }

    /// Byte offsets only grow while tokenizing, so `end` never precedes `start`.
    static func range(from start: Text.Position, to end: Text.Position) -> Text.Range {
        do throws(Text.Range.Error) {
            return try Text.Range(start: start, end: end)
        } catch {
            preconditionFailure("Tokenizer byte offsets only grow: \(error)")
        }
    }
}
