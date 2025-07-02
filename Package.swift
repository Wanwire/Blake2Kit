// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "Blake2Kit",
  platforms: [.iOS(.v16), .macOS(.v14), .macCatalyst(.v16), .tvOS(.v17), .visionOS(.v1)],
  products: [
    .library(
        name: "Blake2Kit",
        targets: ["Blake2Kit"]
    )
  ],
  targets: [
    .target(
        name: "Blake2C",
        publicHeadersPath: "."
    ),
    .target(
        name: "Blake2Kit",
        dependencies: ["Blake2C"]
    ),
    .testTarget(
        name: "Blake2KitTests",
        dependencies: ["Blake2Kit"]
    )
  ]
)
