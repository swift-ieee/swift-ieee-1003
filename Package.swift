// swift-tools-version: 6.3.1

import PackageDescription

let package = Package(
    name: "swift-ieee-1003",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26),
    ],
    products: [
        // MARK: - Namespace
        .library(
            name: "IEEE_1003 Namespace",
            targets: ["IEEE_1003 Namespace"]
        ),

        // MARK: - Core + Variants
        .library(
            name: "IEEE_1003 Core",
            targets: ["IEEE_1003 Core"]
        ),
        .library(
            name: "IEEE_1003 UtilitySyntax",
            targets: ["IEEE_1003 UtilitySyntax"]
        ),

        // MARK: - Umbrella
        .library(
            name: "IEEE_1003",
            targets: ["IEEE_1003"]
        ),

        // MARK: - Test Support
        .library(
            name: "IEEE_1003 Test Support",
            targets: ["IEEE_1003 Test Support"]
        ),
    ],
    dependencies: [
        .package(path: "../../swift-primitives/swift-argument-primitives"),
        .package(path: "../../swift-primitives/swift-parser-primitives"),
    ],
    targets: [
        // MARK: - Namespace
        .target(
            name: "IEEE_1003 Namespace",
            dependencies: []
        ),

        // MARK: - Core
        .target(
            name: "IEEE_1003 Core",
            dependencies: [
                "IEEE_1003 Namespace",
                .product(name: "Argument Primitives Core", package: "swift-argument-primitives"),
            ]
        ),

        // MARK: - UtilitySyntax
        .target(
            name: "IEEE_1003 UtilitySyntax",
            dependencies: [
                "IEEE_1003 Core",
                .product(name: "Argument Primitives", package: "swift-argument-primitives"),
                .product(name: "Parser Primitives", package: "swift-parser-primitives"),
            ]
        ),

        // MARK: - Umbrella
        .target(
            name: "IEEE_1003",
            dependencies: [
                "IEEE_1003 Namespace",
                "IEEE_1003 Core",
                "IEEE_1003 UtilitySyntax",
            ]
        ),

        // MARK: - Test Support
        .target(
            name: "IEEE_1003 Test Support",
            dependencies: [
                "IEEE_1003",
                .product(name: "Argument Primitives Test Support", package: "swift-argument-primitives"),
            ],
            path: "Tests/Support"
        ),

        // MARK: - Tests
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
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
