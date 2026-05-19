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

@Suite("IEEE 1003.UtilitySyntax namespace")
struct IEEE_1003_UtilitySyntax_NamespaceTests {
    @Test("Namespace is reachable")
    func namespaceIsReachable() {
        // Compile-only: confirm that IEEE_1003 and IEEE_1003.UtilitySyntax
        // namespaces are reachable from a consumer importing the Test Support
        // umbrella.
        let _: IEEE_1003.UtilitySyntax.Token.Kind = .endOfOptions
    }
}
