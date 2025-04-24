// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SimpleSFSymbols",
    platforms: [
        .macOS(.v11), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .visionOS(.v1)
    ],
    products: [
        .library(
            name: "SimpleSFSymbols",
            targets: ["SimpleSFSymbols"]
        ),
        .plugin(
            name: "SymbolGeneratorPlugin",
            targets: ["SymbolGeneratorPlugin"]
        ),
    ],
    targets: [
        .target(
            name: "SimpleSFSymbols"
        ),
        .testTarget(
            name: "SimpleSFSymbolsTests",
            dependencies: ["SimpleSFSymbols"]
        ),
        .executableTarget(
            name: "GenerateSymbols"
        ),
        .plugin(
            name: "SymbolGeneratorPlugin",
            capability: .command(
                intent: .custom(verb: "generatesymbols", description: "Generate Symbols"),
                permissions: [.writeToPackageDirectory(reason: "Generates symbol accessor code")]
            ),
            dependencies: [.target(name: "GenerateSymbols")]
        ),
    ]
)
