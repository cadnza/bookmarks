import ArgumentParser
import Foundation

struct Bookmarks: ParsableCommand {

	static let ds: DataSource = try! DataSource()

	static let configuration = CommandConfiguration(
		abstract: "Sweet and simple web bookmarks manager",
		subcommands: [Add.self, List.self]
	)

}

Bookmarks.List.main()  // FIXME: Remove
