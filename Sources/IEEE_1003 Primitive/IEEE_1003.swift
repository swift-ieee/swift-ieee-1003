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

/// Namespace for IEEE 1003 (POSIX): Portable Operating System Interface.
///
/// IEEE Std 1003.1-2017 defines the POSIX standards. This namespace
/// implements the portions of the POSIX standard that are spec-mirrored
/// at L2 in the institute architecture per [API-NAME-003] and
/// [ARCH-LAYER-001].
///
/// ## v1 scope
///
/// - `IEEE_1003.UtilitySyntax` — Chapter 12: Utility Conventions. The
///   14 numbered guidelines defining short-flag syntax (`-f`, `-fvalue`,
///   `-abc` clustering), the `--` separator, and positional arguments.
///
/// ## Future additions
///
/// Future POSIX chapters land in this same package as their respective
/// sub-namespaces, e.g. `IEEE_1003.RegularExpressions.*`,
/// `IEEE_1003.Pathname.*`. The package name follows the institute's
/// `swift-{org}-{number}` precedent — number identifies the standards
/// document, sub-namespaces identify the chapters/topics.
///
/// ## Layer
///
/// L2 standards — implements a published specification. Vocabulary lives
/// at L1 (`Argument.*` in `swift-argument-primitives`); the composed
/// argument-parser foundation lives at L3 (`swift-arguments`).
public enum IEEE_1003 {}
