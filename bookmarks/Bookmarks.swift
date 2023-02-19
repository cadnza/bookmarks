import ArgumentParser
import Chalk
import Foundation

@main
struct Bookmarks: ParsableCommand {

	static var ds: DataSource = try! DataSource()

	static let configuration = CommandConfiguration(
		abstract: "Sweet and simple web bookmarks manager.",
		// swiftlint:disable line_length
		discussion: [
			"Keeps all your web bookmarks in \(ds.configURL.path), which you can symlink from Dropbox, a Git repo, or really anywhere else.",
			"This tool is primarily meant as a backend script for more accessible UI applications, but it works just fine in the command line as well.",
			"Provided are four base commands for manipulating bookmarks (\(Add._commandName), \(Remove._commandName), \(Update._commandName), \(List._commandName))"
				+ " as well as two convenience commands (\(UpdateTag._commandName) and \(ListTags._commandName)).",
			"Run the appropriate command to generate completions for your shell:",
			["bash", "zsh", "fish"]
				.map { "\(indentSpacer)bookmarks --generate-completion-script \($0)" }
				.reduce(into: "") { partialResult, x in
					partialResult += "\n\(x)"
				}
				.trimmingCharacters(in: .newlines),
		]
		// swiftlint:enable line_length
		.reduce(into: "") { partialResult, x in
			partialResult += "\n\n\(x)"
		}
		.trimmingCharacters(in: .whitespacesAndNewlines),
		subcommands: [
			Add.self,
			Remove.self,
			Update.self,
			List.self,
			UpdateTag.self,
			ListTags.self,
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
