// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "plCLI",
    platforms: [
            .macOS(.v14),
			.iOS(.v16)
        ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0" ),
        .package(url: "https://github.com/swiftcsv/SwiftCSV.git", from: "0.8.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "plCLI",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "SwiftCSV", package: "swiftcsv")
            ],
            path: "Sources"),
    ]
)
