// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "bookmarks",
	platforms: [
		.macOS(.v10_15)
	],
	dependencies: [
		.package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
		.package(url: "https://github.com/mxcl/Chalk", from: "0.5.0")
	],
	targets: [
		.executableTarget(
			name: "bookmarks",
			dependencies: [
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
				"Chalk"
			]),
		.testTarget(
			name: "bookmarksTests",
			dependencies: ["bookmarks"])
	]
)
