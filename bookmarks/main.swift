import ArgumentParser
import Foundation

struct Bookmarks: ParsableCommand {

	static var ds: DataSource = try! DataSource()

	static let configuration = CommandConfiguration(
		abstract: "Sweet and simple web bookmarks manager",
		discussion: "", // TODO: Write this
		subcommands: [Add.self, List.self, Remove.self, Update.self]
	)

	static let idsWarningNote =
		"NOTE: Bookmark IDs are NOT STATIC and WILL CHANGE as you add and remove bookmarks."

}

Bookmarks.main()  // FIXME: Remove args
