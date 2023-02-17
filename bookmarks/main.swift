import ArgumentParser
import Foundation

struct Bookmarks: ParsableCommand {

	static var ds: DataSource = try! DataSource()

	static let configuration = CommandConfiguration(
		abstract: "Sweet and simple web bookmarks manager",
		subcommands: [Add.self, List.self]
	)

}

Bookmarks.main(["add", "ORANGES", "oranges.com"])  // FIXME: Remove args
