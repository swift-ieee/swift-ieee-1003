# IEEE 1003

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Swift implementation of IEEE 1003 (POSIX) Chapter 12 — Utility Conventions. v1 ships argv tokenization per the POSIX 12.2 Utility Syntax Guidelines, surfaced as `IEEE_1003.UtilitySyntax.Tokenizer` (a `Parser.Protocol` conformer) plus the 14 numbered guidelines as type-level documentation with validators on the load-bearing ones.

> **Specification identity**: IEEE Std 1003.1 and ISO/IEC/IEEE 9945 are the **same joint
> standard** (POSIX) under two authorities' designations, encoded per volume in this
> ecosystem. This package carries the Base Definitions volume's Chapter 12 Utility
> Conventions (`IEEE_1003`). Sibling volume of the same joint standard:
> [`swift-iso/swift-iso-9945`](https://github.com/swift-iso/swift-iso-9945) — the System
> Interfaces volume (`ISO_9945`). Neither package supersedes the other; they implement
> disjoint volumes of one specification.

---

## Key Features

- **Spec-mirroring** — namespace `IEEE_1003` and sub-namespace `IEEE_1003.UtilitySyntax` mirror IEEE Std 1003.1-2017 §12 verbatim, following the ecosystem's specification-mirroring naming convention. Guidelines `G1` through `G14` mirror "Guideline N" numbering with `description` carrying the spec text and `isValid` / `isOptionShaped` / `isEndOfOptions` static methods on the load-bearing ones.
- **L2 intermediate tokens** — `IEEE_1003.UtilitySyntax.Token` is a POSIX-shaped token type distinct from L1's `Argument.Token`. L3 (`swift-arguments`) maps L2 tokens to L1 tokens when composing the full argv pipeline.
- **Parser.Protocol tokenizer** — `IEEE_1003.UtilitySyntax.Tokenizer` is a leaf `Parser.Protocol` conformer over `[Swift.String]` argv. The Tokenizer one-shot-consumes input and emits `[Token]` classified per Guidelines 3, 4, 5, 6, 7, 9, 10.
- **Typed throws** — `IEEE_1003.UtilitySyntax.Error` is a typed-throws domain; each case names the POSIX 12.2 Guideline it is keyed to.
- **Foundation-free** — no `import Foundation` anywhere. Compiles on Embedded targets, following the standards-layer's no-Foundation discipline.

---

## Quick Start

### Tokenizing argv

```swift
import IEEE_1003

var argv: [String] = ["-f", "value", "--", "operand"]
let tokens = try IEEE_1003.UtilitySyntax.Tokenizer().parse(&argv)

// tokens.map(\.kind) == [
//     .shortFlag("f"),
//     .operand("value"),
//     .endOfOptions,
//     .operand("operand"),
// ]
```

After a successful tokenization, `argv` is empty — the tokenizer consumes the entire input.

### Validating individual characters per Guideline 3

```swift
import IEEE_1003

IEEE_1003.UtilitySyntax.Guideline.G3.isValid("f")   // true
IEEE_1003.UtilitySyntax.Guideline.G3.isValid("ø")   // false
IEEE_1003.UtilitySyntax.Guideline.G3.isValid("!")   // false
```

### Recognizing the end-of-options separator per Guideline 10

```swift
IEEE_1003.UtilitySyntax.Guideline.G10.isEndOfOptions("--")    // true
IEEE_1003.UtilitySyntax.Guideline.G10.isEndOfOptions("---")   // false
```

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-ieee/swift-ieee-1003.git", branch: "main"),
],
targets: [
    .target(
        name: "MyTarget",
        dependencies: [
            .product(name: "IEEE_1003", package: "swift-ieee-1003"),
        ]
    ),
],
```

For consumers needing only the tokenizer machinery:

```swift
.product(name: "IEEE_1003 UtilitySyntax", package: "swift-ieee-1003"),
```

---

## Products

| Product | Contents | Import when... |
|---|---|---|
| `IEEE_1003 Namespace` | `public enum IEEE_1003 {}` only | Adding sub-namespaces without depending on Core's catalog |
| `IEEE_1003 Core` | `IEEE_1003.UtilitySyntax` sub-namespace declaration; re-exports `Argument Primitives Core` | Authoring code that uses Argument-domain vocabulary alongside IEEE_1003 |
| `IEEE_1003 UtilitySyntax` | `IEEE_1003.UtilitySyntax.Token`, `Token.Kind`, `Tokenizer`, `Guideline.G1`–`G14`, `Error` | Tokenizing argv per POSIX 12.2 |
| `IEEE_1003` | Umbrella — re-exports every sub-target | General consumers; L3 schema authors |
| `IEEE_1003 Test Support` | Fixture helpers (`Token.fixture(_:)`); re-exports `Argument Primitives Test Support` along the same dependency spine | Test targets verifying tokenization |

---

## Architecture

```
IEEE_1003
└── UtilitySyntax                       — IEEE Std 1003.1-2017 §12.2 Utility Syntax Guidelines
    ├── Token                            — L2 intermediate token (distinct from L1's Argument.Token)
    │   └── Kind                         — shortFlag(Char) | shortValue | shortCluster | operand | endOfOptions
    ├── Tokenizer                        — Parser.`Protocol` from [String] argv to [Token]
    ├── Error                            — typed-throws errors keyed to Guideline violations
    └── Guideline
        ├── G1                            — Utility name length (2–9 chars)             [doc only]
        ├── G2                            — Utility name character set                  [doc only]
        ├── G3                            — Option-name shape (single alphanumeric)     [load-bearing; isValid]
        ├── G4                            — Options preceded by '-'                     [load-bearing; isOptionShaped]
        ├── G5                            — Clustering                                  [load-bearing; isValidCluster]
        ├── G6                            — Option-argument separation                  [load-bearing; doc]
        ├── G7                            — Option-arguments not optional               [load-bearing; doc]
        ├── G8                            — Multi-value option-arguments                [doc only]
        ├── G9                            — Options precede operands                    [load-bearing; doc]
        ├── G10                           — End-of-options separator                    [load-bearing; isEndOfOptions]
        ├── G11                           — Option ordering                             [doc only]
        ├── G12                           — Operand ordering                            [doc only]
        ├── G13                           — Standard-input operand                      [doc only]
        └── G14                           — Default operand                             [doc only]
```

The L2 tokenizer composes with L3 in `swift-arguments`: that package maps `IEEE_1003.UtilitySyntax.Token` (POSIX-shaped) to L1's `Argument.Token` (post-normalization), and adds GNU long-option handling inline per the v1 scope discipline.

---

## Platform Support

Compiles on every platform with a Swift 6.3+ toolchain. No Foundation dependency, no platform-specific code.

---

## Error Handling

`IEEE_1003.UtilitySyntax.Error` is the typed-throws domain for tokenization failures. Each case names the POSIX 12.2 Guideline it is keyed to:

```swift
switch error {
case .invalidShortFlagCharacter(let char, let argvIndex, let byteOffset):
    // Guideline 3: option names must be a single alphanumeric character.
case .leadingDashWithoutFlag(let argvIndex):
    // Guideline 4: bare '-' is not an option.
case .emptyArgvElement(let argvIndex):
    // Empty argv element; not a Guideline-keyed failure, but an argv-shape problem.
}
```

L3 consumers typically wrap these into `Argument.Error` (with `Argument.Position` populated from the per-case `argvIndex` + `byteOffset`).

---

## Related Packages

- [`swift-argument-primitives`](https://github.com/swift-primitives/swift-argument-primitives) — L1 vocabulary (`Argument.Name`, `Argument.Arity`, `Argument.Token`, schema-as-data combinators). This package depends on it.
- [`swift-parser-primitives`](https://github.com/swift-primitives/swift-parser-primitives) — the `Parser.Protocol` substrate. `Tokenizer` conforms to it.
- [`swift-arguments`](https://github.com/swift-foundations/swift-arguments) (L3 foundations) — composes this package with GNU long-options inline and emits an `Argument.Token` stream to schema-bound parsers.

---

## Stability

Pre-1.0. The public API surface — namespace, type, and case names — is stable for the v1 scope documented in `Research/2026-05-15-swift-arguments-ecosystem-design.md` in the swift-institute repo. Additions are SemVer-additive; renames or case structure changes are SemVer-breaking.

---

## License

Apache 2.0 — see [LICENSE.md](./LICENSE.md).

---

## Community

<!-- discussion-link:start -->
<!-- discussion-link:end -->
