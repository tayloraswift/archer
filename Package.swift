// swift-tools-version:6.0
import PackageDescription

let package:Package = .init(name: "archer",
    platforms: [.macOS(.v15), .iOS(.v18), .visionOS(.v2)],
    products: [
        .executable(name: "archer", targets: ["ArcherCommands"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.5.0"),
        .package(url: "https://github.com/swiftwasm/WasmTransformer", from: "0.5.0"),
        .package(url: "https://github.com/tayloraswift/swift-io", branch: "master"),
    ],
    targets: [
        .executableTarget(name: "ArcherCommands",
            dependencies: [
                .target(name: "Archer"),
                .target(name: "_GitVersion"),

                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "System_ArgumentParser", package: "swift-io"),
            ]),
        .target(name: "Archer",
            dependencies: [
                .product(name: "SystemIO", package: "swift-io"),
                .product(name: "WasmTransformer", package: "WasmTransformer"),
            ]),

        .target(name: "_GitVersion",
            cSettings: [
                .define("SWIFTPM_GIT_VERSION", to: "\"\(version)\"")
            ]),
    ])

for target:PackageDescription.Target in package.targets
{
    {
        var settings:[PackageDescription.SwiftSetting] = $0 ?? []

        settings.append(.enableUpcomingFeature("ExistentialAny"))
        settings.append(.enableExperimentalFeature("StrictConcurrency"))

        settings.append(.define("DEBUG", .when(configuration: .debug)))

        $0 = settings
    } (&target.swiftSettings)
}

var version:String
{
    if  let git:GitInformation = Context.gitInformation
    {
        let base:String = git.currentTag ?? git.currentCommit
        return git.hasUncommittedChanges ? "\(base) (modified)" : base
    }
    else
    {
        return "(untracked)"
    }
}
