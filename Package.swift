// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LuaSwift",
    products: [
        .library(
            name: "LuaSwift",
            targets: ["LuaSwift"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "LuaSwift", dependencies: ["lua"]),
        .executableTarget(name: "LuaDemo", dependencies: ["LuaSwift"]),
        .systemLibrary(name: "lua", pkgConfig: "lua", providers: [.brew(["lua"])]),
        .testTarget(name: "LuaDemoTests", dependencies: ["LuaDemo"]),
        .testTarget(
            name: "LuaSwiftTests",
            dependencies: ["LuaSwift"]),
    ]
)

