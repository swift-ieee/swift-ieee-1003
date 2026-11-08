import Testing

@testable import IEEE_1003_Test_Support

enum `IEEE_1003.UtilitySyntax Tests` {}

extension `IEEE_1003.UtilitySyntax Tests` {
    @Suite
    struct Test {
        @Suite
        struct Unit {
            @Test
            func `namespace is reachable`() {

                let _: IEEE_1003.UtilitySyntax.Token.Kind = .endOfOptions
            }
        }

        @Suite
        struct `Edge Case` {}

        @Suite
        struct Integration {}
    }
}
