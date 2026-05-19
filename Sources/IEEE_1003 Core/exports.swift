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

@_exported public import Argument_Primitives_Core
// Re-export the namespace and Argument-domain core vocabulary per
// [ARCH-LAYER-002] preferred-shape — downstream consumers of
// `IEEE_1003 Core` get Argument-domain types (Argument.Token,
// Argument.Name, Argument.Error, Text.Range via Tagged/Text
// transitive re-exports) without a separate import.
@_exported public import IEEE_1003_Namespace
