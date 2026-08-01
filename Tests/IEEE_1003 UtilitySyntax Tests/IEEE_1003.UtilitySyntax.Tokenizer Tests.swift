// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-ieee-1003 open source project
//
// Copyright (c) 2026 Coen ten Thije Boonkkamp and the swift-ieee-1003 project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

import Testing

@testable import IEEE_1003_Test_Support

extension IEEE_1003.UtilitySyntax.Tokenizer {
    @Suite("IEEE 1003.UtilitySyntax.Tokenizer")
    struct Test {
        @Suite
        struct Unit {

            // MARK: - Canonical argv inputs

            @Test
            func `single short flag`() throws {
                var argv: [String] = ["-f"]
                let tokens = try IEEE_1003.UtilitySyntax.Tokenizer().parse(&argv)
                #expect(tokens.map(\.kind) == [.shortFlag("f")])
                #expect(argv.isEmpty)
            }

            @Test
            func `short flag with concatenated value`() throws {
                var argv: [String] = ["-fvalue"]
                let tokens = try IEEE_1003.UtilitySyntax.Tokenizer().parse(&argv)
                #expect(
                    tokens.map(\.kind) == [
                        .shortFlag("f"),
                        .shortValue("value"),
                    ]
                )
            }

            @Test
            func `cluster shaped default`() throws {
                var argv: [String] = ["-abc"]
                let tokens = try IEEE_1003.UtilitySyntax.Tokenizer().parse(&argv)
                // L2 default policy: emit Guideline-6 concatenated form. L3 re-classifies
                // into Guideline-5 cluster form (`.shortCluster("bc")`) when the schema
                // indicates `a` is a value-less flag.
                #expect(
                    tokens.map(\.kind) == [
                        .shortFlag("a"),
                        .shortValue("bc"),
                    ]
                )
            }

            @Test
            func `end of options`() throws {
                var argv: [String] = ["--", "value"]
                let tokens = try IEEE_1003.UtilitySyntax.Tokenizer().parse(&argv)
                #expect(
                    tokens.map(\.kind) == [
                        .endOfOptions,
                        .operand("value"),
                    ]
                )
            }

            @Test
            func `operand only`() throws {
                var argv: [String] = ["hello"]
                let tokens = try IEEE_1003.UtilitySyntax.Tokenizer().parse(&argv)
                #expect(tokens.map(\.kind) == [.operand("hello")])
            }

            @Test
            func `bare dash is operand`() throws {
                var argv: [String] = ["-"]
                let tokens = try IEEE_1003.UtilitySyntax.Tokenizer().parse(&argv)
                #expect(tokens.map(\.kind) == [.operand("-")])
            }

            @Test
            func `empty argv`() throws {
                var argv: [String] = []
                let tokens = try IEEE_1003.UtilitySyntax.Tokenizer().parse(&argv)
                #expect(tokens.isEmpty)
            }

            @Test
            func `multiple separate short flags`() throws {
                var argv: [String] = ["-f", "-v", "-z"]
                let tokens = try IEEE_1003.UtilitySyntax.Tokenizer().parse(&argv)
                #expect(
                    tokens.map(\.kind) == [
                        .shortFlag("f"),
                        .shortFlag("v"),
                        .shortFlag("z"),
                    ]
                )
            }

            @Test
            func `mixed sequence`() throws {
                var argv: [String] = ["-f", "value", "--", "operand"]
                let tokens = try IEEE_1003.UtilitySyntax.Tokenizer().parse(&argv)
                #expect(
                    tokens.map(\.kind) == [
                        .shortFlag("f"),
                        .operand("value"),
                        .endOfOptions,
                        .operand("operand"),
                    ]
                )
            }
        }

        @Suite
        struct `Edge Case` {

            // MARK: - Guideline-keyed error cases

            @Test
            func `non alphanumeric short flag`() throws {
                var argv: [String] = ["-!"]
                do throws(IEEE_1003.UtilitySyntax.Error) {
                    _ = try IEEE_1003.UtilitySyntax.Tokenizer().parse(&argv)
                    Issue.record("Expected throw")
                } catch let error {
                    switch error {
                    case .invalidShortFlagCharacter(let found, let argvIndex, let byteOffset):
                        #expect(found == "!")
                        #expect(argvIndex == 0)
                        #expect(byteOffset == 1)

                    case .leadingDashWithoutFlag, .emptyArgvElement:
                        Issue.record("Wrong error case: \(error)")
                    }
                }
            }
        }

        @Suite
        struct Integration {

            // MARK: - Range semantics smoke test

            @Test
            func `token ranges are monotonic`() throws {
                var argv: [String] = ["-f", "value", "--", "operand"]
                let tokens = try IEEE_1003.UtilitySyntax.Tokenizer().parse(&argv)

                // Each token's start should be >= the previous token's start.
                // (Token end >= start is the Text.Range invariant.)
                var lastStart: Text.Position? = nil
                for token in tokens {
                    if let last = lastStart {
                        #expect(token.range.start >= last)
                    }
                    lastStart = token.range.start
                }
            }

            @Test
            func `input consumed fully`() throws {
                var argv: [String] = ["-f", "operand"]
                _ = try IEEE_1003.UtilitySyntax.Tokenizer().parse(&argv)
                #expect(argv.isEmpty)
            }
        }
    }
}

extension IEEE_1003.UtilitySyntax.Guideline {
    @Suite("IEEE 1003.UtilitySyntax.Guideline static validators")
    struct Test {
        @Suite
        struct Unit {
            @Test
            func `g3 accepts alphanumeric`() {
                #expect(IEEE_1003.UtilitySyntax.Guideline.G3.isValid("a"))
                #expect(IEEE_1003.UtilitySyntax.Guideline.G3.isValid("Z"))
                #expect(IEEE_1003.UtilitySyntax.Guideline.G3.isValid("5"))
            }

            @Test
            func `g4 option shape`() {
                #expect(IEEE_1003.UtilitySyntax.Guideline.G4.isOptionShaped("-f"))
                #expect(IEEE_1003.UtilitySyntax.Guideline.G4.isOptionShaped("-fvalue"))
                #expect(IEEE_1003.UtilitySyntax.Guideline.G4.isOptionShaped("-abc"))

                #expect(!IEEE_1003.UtilitySyntax.Guideline.G4.isOptionShaped("-"))
                #expect(!IEEE_1003.UtilitySyntax.Guideline.G4.isOptionShaped("--"))
                #expect(!IEEE_1003.UtilitySyntax.Guideline.G4.isOptionShaped("operand"))
                #expect(!IEEE_1003.UtilitySyntax.Guideline.G4.isOptionShaped(""))
            }

            @Test
            func `g5 cluster validation`() {
                #expect(IEEE_1003.UtilitySyntax.Guideline.G5.isValidCluster("abc"))
                #expect(IEEE_1003.UtilitySyntax.Guideline.G5.isValidCluster("xvf"))
                #expect(IEEE_1003.UtilitySyntax.Guideline.G5.isValidCluster("a"))

                #expect(!IEEE_1003.UtilitySyntax.Guideline.G5.isValidCluster(""))
                #expect(!IEEE_1003.UtilitySyntax.Guideline.G5.isValidCluster("a!b"))
                #expect(!IEEE_1003.UtilitySyntax.Guideline.G5.isValidCluster("a-b"))
            }

            @Test
            func `g10 end of options`() {
                #expect(IEEE_1003.UtilitySyntax.Guideline.G10.isEndOfOptions("--"))

                #expect(!IEEE_1003.UtilitySyntax.Guideline.G10.isEndOfOptions("-"))
                #expect(!IEEE_1003.UtilitySyntax.Guideline.G10.isEndOfOptions("---"))
                #expect(!IEEE_1003.UtilitySyntax.Guideline.G10.isEndOfOptions("--foo"))
                #expect(!IEEE_1003.UtilitySyntax.Guideline.G10.isEndOfOptions(""))
            }

            @Test
            func `all guideline descriptions exist`() {
                #expect(!IEEE_1003.UtilitySyntax.Guideline.G1.description.isEmpty)
                #expect(!IEEE_1003.UtilitySyntax.Guideline.G2.description.isEmpty)
                #expect(!IEEE_1003.UtilitySyntax.Guideline.G3.description.isEmpty)
                #expect(!IEEE_1003.UtilitySyntax.Guideline.G4.description.isEmpty)
                #expect(!IEEE_1003.UtilitySyntax.Guideline.G5.description.isEmpty)
                #expect(!IEEE_1003.UtilitySyntax.Guideline.G6.description.isEmpty)
                #expect(!IEEE_1003.UtilitySyntax.Guideline.G7.description.isEmpty)
                #expect(!IEEE_1003.UtilitySyntax.Guideline.G8.description.isEmpty)
                #expect(!IEEE_1003.UtilitySyntax.Guideline.G9.description.isEmpty)
                #expect(!IEEE_1003.UtilitySyntax.Guideline.G10.description.isEmpty)
                #expect(!IEEE_1003.UtilitySyntax.Guideline.G11.description.isEmpty)
                #expect(!IEEE_1003.UtilitySyntax.Guideline.G12.description.isEmpty)
                #expect(!IEEE_1003.UtilitySyntax.Guideline.G13.description.isEmpty)
                #expect(!IEEE_1003.UtilitySyntax.Guideline.G14.description.isEmpty)
            }
        }

        @Suite
        struct `Edge Case` {
            @Test
            func `g3 rejects invalid`() {
                #expect(!IEEE_1003.UtilitySyntax.Guideline.G3.isValid("!"))
                #expect(!IEEE_1003.UtilitySyntax.Guideline.G3.isValid("-"))
                #expect(!IEEE_1003.UtilitySyntax.Guideline.G3.isValid("ø"))
                #expect(!IEEE_1003.UtilitySyntax.Guideline.G3.isValid(" "))
            }
        }

        @Suite
        struct Integration {}
    }
}

extension IEEE_1003.UtilitySyntax.Token {
    @Suite("IEEE 1003.UtilitySyntax.Token equality")
    struct Test {
        @Suite
        struct Unit {
            @Test
            func `fixture helper round trips`() {
                let a = IEEE_1003.UtilitySyntax.Token.fixture(.shortFlag("f"))
                let b = IEEE_1003.UtilitySyntax.Token.fixture(.shortFlag("f"))
                #expect(a == b)
            }

            @Test
            func `short flags per character`() {
                let a = IEEE_1003.UtilitySyntax.Token.fixture(.shortFlag("f"))
                let b = IEEE_1003.UtilitySyntax.Token.fixture(.shortFlag("g"))
                #expect(a != b)
            }
        }

        @Suite
        struct `Edge Case` {}

        @Suite
        struct Integration {}
    }
}
