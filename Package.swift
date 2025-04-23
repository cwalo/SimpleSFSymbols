// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SimpleSFSymbols",
    platforms: [
        .macOS(.v11), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .visionOS(.v1)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SimpleSFSymbols",
            targets: ["SimpleSFSymbols"]),
        .plugin(
            name: "SymbolGeneratorPlugin",
            targets: [
                "SymbolGeneratorPlugin"
            ]
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .plugin(
            name: "SymbolGeneratorPlugin",
            capability:
                .command(intent: .custom(
                    verb: "generate-package-metadata",
                    description: "Generate Package Metadata"
                ),
                permissions: [
                    .writeToPackageDirectory(reason: "Generates symbols")
                ]
            ),
            dependencies: ["GenerateSymbols"]
        ),
        .executableTarget(
            name: "GenerateSymbols"
        ),
        .target(
            name: "SimpleSFSymbols"
        ),
        .testTarget(
            name: "SimpleSFSymbolsTests",
            dependencies: ["SimpleSFSymbols"]
        ),
    ]
)
