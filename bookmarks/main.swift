import ArgumentParser
import Chalk
import Foundation

struct Bookmarks: ParsableCommand {

	static let ds: DataSource = try! DataSource()

	static let configuration = CommandConfiguration(
		abstract: "Sweet and simple web bookmarks manager",
		subcommands: [Add.self, List.self]
	)

	static func exitWithError(_ message: String, _ code: Int32) -> Never {
		let colorError = Color.red
		fputs(
			"\(message, color: colorError)\n",
			stderr
		)
		Bookmarks.exit(
			withError: ExitCode(code)
		)
	}

}

Bookmarks.main(["list"])  // FIXME: Remove args
