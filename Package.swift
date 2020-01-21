// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "HandsomeAssert",
    products: [
        .library(
            name: "HandsomeAssert",
            targets: ["HandsomeAssert"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "HandsomeAssert",
            dependencies: []
        ),
        .testTarget(
            name: "HandsomeAssertTests",
            dependencies: ["HandsomeAssert"]
        ),
    ]
)
