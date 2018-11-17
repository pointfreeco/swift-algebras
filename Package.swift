// swift-tools-version:4.2

import PackageDescription

let package = Package(
  name: "Monoid",
  products: [
    .library(
      name: "Monoid",
      targets: ["Monoid"]),
    ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "Monoid",
      dependencies: []),
    .testTarget(
      name: "MonoidTests",
      dependencies: ["Monoid"]),
    ]
)
