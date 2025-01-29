// swift-tools-version:6.0
import PackageDescription

let package:Package = .init(name: "WebAssembly Example",
    products: [
        .executable(name: "Hello", targets: ["Hello"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftwasm/JavaScriptKit", from: "0.21.0"),
    ],
    targets: [
        .executableTarget(name: "Hello",
            dependencies: [
                .product(name: "JavaScriptKit", package: "JavaScriptKit"),
            ]),
    ])
