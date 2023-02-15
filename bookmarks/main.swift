import ArgumentParser
import Foundation

struct Bookmarks: ParsableCommand {

	static let config: URL = URL(
		fileURLWithPath: ProcessInfo.processInfo.environment["HOME"] ?? "/"
	)
	.appendingPathComponent(".bookmarks")

	static let configuration = CommandConfiguration(
		abstract: "Sweet and simple web bookmarks manager.",
		subcommands: [Add.self]
	)

	struct Add: ParsableCommand {
		func run() {
			print(2) // TODO
		}
	}

}
