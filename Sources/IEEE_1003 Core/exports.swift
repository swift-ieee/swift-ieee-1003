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

@_exported public import Argument_Primitives
// Re-export the namespace and Argument-domain core vocabulary per
// [ARCH-LAYER-002] preferred-shape — downstream consumers of
// `IEEE_1003 Core` get Argument-domain types (Argument.Token,
// Argument.Name, Argument.Error) without a separate import. Foreign
// domains (Text, Index) are no longer carried transitively now that this
// anchors on the `Argument Primitives` umbrella rather than the dissolved
// `Argument Primitives Core` shim; consumers needing them import directly
// per [MOD-038].
@_exported public import IEEE_1003_Primitive
