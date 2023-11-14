// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EventTriggeredButton",
    platforms: [
        .macOS(.v13),
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "EventTriggeredButton",
            targets: ["EventTriggeredButton"]),
    ],
    targets: [
        .target(
            name: "EventTriggeredButton"),
        .testTarget(
            name: "EventTriggeredButtonTests",
            dependencies: ["EventTriggeredButton"]),
    ]
)
