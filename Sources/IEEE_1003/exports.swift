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

@_exported public import IEEE_1003_Core
// Umbrella target per [MOD-005] — re-exports every sub-target. Downstream
// consumers `import IEEE_1003` to get the full L2 surface. Future POSIX
// chapters (e.g., `IEEE_1003.RegularExpressions`, `IEEE_1003.Pathname`)
// land as additional sub-targets here.
@_exported public import IEEE_1003_Primitive
@_exported public import IEEE_1003_UtilitySyntax
