// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "MongoDB",
    platforms: [
        .macOS(.v11)
    ],
    products: [
        .library(name: "MongoDB", targets: ["MongoDB"])
    ],
    dependencies: [
         .package(url: "https://github.com/swift-cloud/Compute", from: "2.0.0")
    ],
    targets: [
        .target(name: "MongoDB", dependencies: ["Compute"]),
        .testTarget(name: "MongoDBTests", dependencies: ["MongoDB"])
    ]
)
