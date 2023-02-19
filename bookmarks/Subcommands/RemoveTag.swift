import ArgumentParser
import Foundation

extension Bookmarks {

	struct RemoveTag: ParsableCommand {

		static let configuration = CommandConfiguration(
			abstract: "Removes a tag from all of its bookmarks."
		)

		@Argument(help: "The tag to remove.")
		var tag: String

		func run() {
		}

		func validate() throws {
		}
	}

}
