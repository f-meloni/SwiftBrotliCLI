// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-brotli",
    products: [
      .executable(name: "swift-brotli", targets: ["SwiftBrotliCLI"])
    ],
    dependencies: [
        .package(url: "https://github.com/f-meloni/SwiftBrotli", from: "0.1.0"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.0.1")
    ],
    targets: [
        .target(
            name: "SwiftBrotliCLI",
            dependencies: ["SwiftBrotli", "ArgumentParser"]),
        .testTarget(
            name: "SwiftBrotliCLITests",
            dependencies: ["SwiftBrotliCLI"]),
    ]
)
