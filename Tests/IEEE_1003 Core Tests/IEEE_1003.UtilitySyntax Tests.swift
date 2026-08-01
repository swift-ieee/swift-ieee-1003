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

extension IEEE_1003.UtilitySyntax {
    @Suite("IEEE 1003.UtilitySyntax namespace")
    struct Test {
        @Suite
        struct Unit {
            @Test
            func `namespace is reachable`() {
                // Compile-only: confirm that IEEE_1003 and IEEE_1003.UtilitySyntax
                // namespaces are reachable from a consumer importing the Test Support
                // umbrella.
                let _: IEEE_1003.UtilitySyntax.Token.Kind = .endOfOptions
            }
        }

        @Suite
        struct `Edge Case` {}

        @Suite
        struct Integration {}
    }
}
