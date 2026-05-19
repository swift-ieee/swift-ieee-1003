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

// Re-export Core (which itself re-exports the Argument-domain core
// vocabulary) per [ARCH-LAYER-002]. Downstream consumers of
// `IEEE_1003 UtilitySyntax` get the L2 namespace + L1 Argument vocabulary
// + Text.Range (via Argument_Primitives_Core transitive re-exports)
// without a separate import.
@_exported public import IEEE_1003_Core
