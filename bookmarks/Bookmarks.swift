import ArgumentParser
import Chalk
import Foundation

@main
struct Bookmarks: ParsableCommand {

	static var ds: DataSource = try! DataSource()

	static let configuration = CommandConfiguration(
		abstract: "Sweet and simple web bookmarks manager.",
		discussion: "",  // TODO: Write this
		subcommands: [
			Add.self,
			List.self,
			Remove.self,
			Update.self,
			ListTags.self,
			UpdateTag.self,
		]
	)

	static let untaggedHeading = "Untagged"
	static let indentSpacer = "  "

	static let tagNullStandin = "null"

	static let idsWarningNote =
		"NOTE: Bookmark IDs are NOT STATIC and WILL CHANGE as you add and remove bookmarks."

	static let colors: [String: Color] = [
		"noTag": .red,
		"tag": .green,
		"url": .blue,
		"id": .magenta,
	]

}
