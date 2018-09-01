// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "INI",
  products: [
      .library(name: "INI", targets: ["INI"]),
  ],
  targets: [
      .target(name: "INI"),
        .testTarget(
            name: "INITests",
            dependencies: ["INI"]),
  ]
)
