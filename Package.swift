// swift-tools-version:6.0
import PackageDescription

let package:Package = .init(name: "archer",
    products: [
        .executable(name: "archer", targets: ["archer"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.5.0"),
        .package(url: "https://github.com/swiftwasm/WasmTransformer", from: "0.5.0"),
        .package(url: "https://github.com/tayloraswift/swift-io", branch: "master"),
    ],
    targets: [
        .executableTarget(name: "archer",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "System_ArgumentParser", package: "swift-io"),
                .product(name: "SystemIO", package: "swift-io"),
                .product(name: "WasmTransformer", package: "WasmTransformer"),
            ]),
    ])
