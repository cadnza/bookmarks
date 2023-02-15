import ArgumentParser
import Foundation

struct Bookmarks: ParsableCommand {

	static let configuration = CommandConfiguration(
		abstract: "Sweet and simple web bookmarks manager",
		subcommands: [Add.self, List.self]
	)

}

Bookmarks.Add.main()  // FIXME: Remove
