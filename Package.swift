// swift-tools-version:6.2
import PackageDescription
import CompilerPluginSupport

let package: Package = .init(
    name: "swift-jwt",
    platforms: [.macOS(.v15), .iOS(.v18), .tvOS(.v18), .watchOS(.v11), .visionOS(.v2)],
    products: [
        .library(name: "JWT", targets: ["JWT"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ordo-one/dollup", from: "1.0.1"),

        .package(url: "https://github.com/rarestype/h", from: "1.0.1"),
        .package(url: "https://github.com/rarestype/swift-json", from: "2.3.2"),
    ],
    targets: [
        .target(
            name: "JWT",
            dependencies: [
                .product(name: "Base64", package: "h"),
                .product(name: "JSON", package: "swift-json"),
            ]
        ),
    ]
)

for target: Target in package.targets {
    {
        var settings: [SwiftSetting] = $0 ?? []

        settings.append(.enableUpcomingFeature("ExistentialAny"))
        settings.append(.enableUpcomingFeature("InternalImportsByDefault"))
        settings.append(.enableExperimentalFeature("StrictConcurrency"))
        settings.append(.define("DEBUG", .when(configuration: .debug)))

        $0 = settings
    } (&target.swiftSettings)
}
