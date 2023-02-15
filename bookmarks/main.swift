import ArgumentParser
import Foundation

let kHomePath: String = ProcessInfo.processInfo.environment["HOME"] ?? "/"
let kConfigName = ".bookmarks"
let kConfig: URL = URL(fileURLWithPath: kHomePath)
	.appendingPathComponent(kConfigName)
