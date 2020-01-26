// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "CuteAsserts",
    products: [
        .library(
            name: "CuteAsserts",
            targets: ["CuteAsserts"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CuteAsserts",
            dependencies: []
        ),
        .testTarget(
            name: "CuteAssertsTests",
            dependencies: ["CuteAsserts"]
        ),
    ]
)
