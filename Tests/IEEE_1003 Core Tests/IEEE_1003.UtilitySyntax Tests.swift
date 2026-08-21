import Testing

@testable import IEEE_1003_Test_Support

extension IEEE_1003.UtilitySyntax {
    @Suite("IEEE 1003.UtilitySyntax namespace")
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
