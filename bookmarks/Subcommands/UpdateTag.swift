import ArgumentParser
import Foundation

extension Bookmarks {

	struct UpdateTag: ParsableCommand {

		static let configuration = CommandConfiguration(
			abstract: "Renames a tag on all of its bookmarks."
		)

		@Argument(help: "The tag to rename.")
		var tag: String

		@Argument(help: "A new name for the tag.")
		var new: String

		func run() {
		}

		func validate() throws {
		}
	}

}
