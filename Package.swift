// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "CuteAssert",
    products: [
        .library(
            name: "CuteAssert",
            targets: ["CuteAssert"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CuteAssert",
            dependencies: []
        ),
        .testTarget(
            name: "CuteAssertTests",
            dependencies: ["CuteAssert"]
        ),
    ]
)
