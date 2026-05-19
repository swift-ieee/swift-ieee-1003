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

@_exported public import Argument_Primitives_Test_Support
// Test Support spine ([MOD-024]).
//
// Anchors on the lowest upstream Test Support module reachable through
// the package's product deps — `Argument Primitives Test Support`. Test
// files for this package inherit the Tagged SLI ergonomics
// (`ExpressibleBy*Literal` conformances on `Tagged`) and the
// `Argument.Schema.Recording` visitor through this re-export chain.
@_exported public import IEEE_1003
