// swiftlint:disable:this file_name
import ArgumentParser
import Foundation

extension Bookmarks.Remove {

	struct Tag: ParsableCommand {

		static let configuration = CommandConfiguration(
			abstract: "Remove a tag from all of its bookmarks"
		)

		@Argument(help: "The tag to remove")
		var tag: String

		func run() {
		}

		func validate() throws {
		}
	}

}
