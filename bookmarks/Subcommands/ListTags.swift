import ArgumentParser
import Chalk
import Foundation

extension Bookmarks {

	struct ListTags: ParsableCommand {

		static let configuration = CommandConfiguration(
			abstract: "List all tags"
		)

		@Flag(name: .shortAndLong, help: "Show output as JSON.")
		private var json = false

		func run() {
		}
	}

}
