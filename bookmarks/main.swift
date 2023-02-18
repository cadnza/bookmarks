import ArgumentParser
import Foundation

struct Bookmarks: ParsableCommand {

	static var ds: DataSource = try! DataSource()

	static let configuration = CommandConfiguration( // TODO: Make sure the other commands have configurations, too
		abstract: "Sweet and simple web bookmarks manager",
		subcommands: [Add.self, List.self, Remove.self, Update.self]
	)

	static let idsWarningNote =
		"- NOTE: Bookmark IDs are NOT STATIC and WILL CHANGE as you add and remove bookmarks."

}

Bookmarks.main()  // FIXME: Remove args
