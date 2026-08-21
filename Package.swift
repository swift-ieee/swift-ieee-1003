// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-ieee-1003",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [

        .library(
            name: "IEEE_1003 Primitive",
            targets: ["IEEE_1003 Primitive"]
        ),

        .library(
            name: "IEEE_1003 Core",
            targets: ["IEEE_1003 Core"]
        ),
        .library(
            name: "IEEE_1003 UtilitySyntax",
            targets: ["IEEE_1003 UtilitySyntax"]
        ),

        .library(
            name: "IEEE_1003",
            targets: ["IEEE_1003"]
        ),

        .library(
            name: "IEEE_1003 Test Support",
            targets: ["IEEE_1003 Test Support"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-primitives/swift-argument-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-parser-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-text-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-index-primitives.git",
            branch: "main"
        ),
    ],
    targets: [

        .target(
            name: "IEEE_1003 Primitive",
            dependencies: []
        ),

        .target(
            name: "IEEE_1003 Core",
            dependencies: [
                "IEEE_1003 Primitive",
                .product(name: "Argument Primitives", package: "swift-argument-primitives"),
            ]
        ),

        .target(
            name: "IEEE_1003 UtilitySyntax",
            dependencies: [
                "IEEE_1003 Core",
                .product(name: "Argument Primitives", package: "swift-argument-primitives"),
                .product(name: "Parser Primitives", package: "swift-parser-primitives"),
                .product(name: "Text Primitives", package: "swift-text-primitives"),
                .product(name: "Index Primitives", package: "swift-index-primitives"),
            ]
        ),

        .target(
            name: "IEEE_1003",
            dependencies: [
                "IEEE_1003 Primitive",
                "IEEE_1003 Core",
                "IEEE_1003 UtilitySyntax",
            ]
        ),

        .target(
            name: "IEEE_1003 Test Support",
            dependencies: [
                "IEEE_1003",
                .product(
                    name: "Argument Primitives Test Support",
                    package: "swift-argument-primitives"
                ),
                .product(name: "Text Primitives", package: "swift-text-primitives"),
                .product(name: "Index Primitives", package: "swift-index-primitives"),
            ],
            path: "Tests/Support"
        ),

        .testTarget(
            name: "IEEE_1003 Core Tests",
            dependencies: ["IEEE_1003 Test Support"]
        ),
        .testTarget(
            name: "IEEE_1003 UtilitySyntax Tests",
            dependencies: ["IEEE_1003 Test Support"]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
