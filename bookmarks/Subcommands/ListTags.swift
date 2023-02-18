// swiftlint:disable:this file_name
import ArgumentParser
import Chalk
import Foundation

extension Bookmarks.List {

	struct Tags: ParsableCommand {

		static let configuration = CommandConfiguration(
			abstract: "List all tags"
		)

		@Flag(name: .shortAndLong, help: "Show output as JSON.")
		private var json = false

		func run() {
		}
	}

}
