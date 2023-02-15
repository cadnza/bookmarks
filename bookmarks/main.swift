import ArgumentParser
import Foundation

struct Bookmarks: ParsableCommand {

	static let config: URL = URL(
		fileURLWithPath: ProcessInfo.processInfo.environment["HOME"] ?? "/"
	)
	.appendingPathComponent(".bookmarks")

	static let configuration = CommandConfiguration(
		abstract: "Sweet and simple web bookmarks manager",
		subcommands: [Add.self]
	)

	struct List: ParsableCommand {
		func run() {

		}
	}

	struct Add: ParsableCommand {

		@Argument(help: "The bookmark's title")
		var title: String

		@Argument(help: "The bookmark's URL")
		var url: String

		@Option(help: "A tag for the bookmark, if you'd like one")
		var tag: String?

		func run() {

		}
	}

}

Bookmarks.Add.main()  // FIXME: Remove
