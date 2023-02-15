import ArgumentParser
import Foundation

struct Bookmarks: ParsableCommand {

	static let configPath: URL = URL(
		fileURLWithPath: ProcessInfo.processInfo.environment["HOME"] ?? "/"
	)
	.appendingPathComponent(".bookmarks")

	static let configuration = CommandConfiguration(
		abstract: "Sweet and simple web bookmarks manager",
		subcommands: [Add.self]
	)

}

Bookmarks.Add.main()  // FIXME: Remove
