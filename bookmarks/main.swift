import ArgumentParser
import Foundation

struct Bookmarks: ParsableCommand {

	enum ExitCodes: Error {
		case general(String)
	}

	static let ds: DataSource = try! DataSource()

	static let configuration = CommandConfiguration(
		abstract: "Sweet and simple web bookmarks manager",
		subcommands: [Add.self, List.self]
	)

}

Bookmarks.main(["list"]) // FIXME: Remove args
