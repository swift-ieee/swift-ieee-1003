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
// Foreign-domain vocabulary used by fixtures and test files:
// `Text.Position` / `Text.Range` (token byte-range provenance) and
// `Ordinal` (range endpoints). Re-exported explicitly here per [MOD-038]
// now that the `IEEE_1003 Core` re-export chain anchors on the
// `Argument Primitives` umbrella, which — unlike the dissolved
// `Argument Primitives Core` shim — does not transitively carry the
// Text / Index domains.
@_exported public import Text_Primitives
@_exported public import Index_Primitives
