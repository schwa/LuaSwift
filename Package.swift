// swift-tools-version: 5.9

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "LuaSwift",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "LuaSwift",
            targets: ["LuaSwift"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", from: "509.0.0-swift-5.9-DEVELOPMENT-SNAPSHOT-2023-04-25-b"),
    ],
    targets: [
        .target(name: "LuaSwift", dependencies: ["lua", "LuaSwiftMacros"]),
        .executableTarget(name: "LuaDemo", dependencies: ["LuaSwift"]),
        .systemLibrary(name: "lua", pkgConfig: "lua", providers: [.brew(["lua"])]),
        .testTarget(name: "LuaDemoTests", dependencies: ["LuaDemo"]),
        .testTarget(
            name: "LuaSwiftTests",
            dependencies: [
                "LuaSwift",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax")
            ]),
        .macro(name: "LuaSwiftMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        )
    ]
)

