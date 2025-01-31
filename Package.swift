// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CombineBinding",
    platforms: [
        .iOS(.v13),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "CombineBinding",
            targets: ["CombineBinding"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "CombineBinding",
            dependencies: []),
        .testTarget(
            name: "CombineBindingTests",
            dependencies: ["CombineBinding"]),
    ]
)
