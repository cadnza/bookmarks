import ArgumentParser
import Foundation

extension Bookmarks {

	struct UpdateTag: ParsableCommand {

		static let configuration = CommandConfiguration(
			abstract: "Renames a tag on all of its bookmarks."
		)

		@Argument(help: "The tag to rename.")
		var oldTag: String

		@Argument(
			help:
				"A new name for the tag, or '\(tagNullStandin)' to remove the tag from all of its bookmarks."
		)
		var newTag: String  // swiftlint:disable:this let_var_whitespace

		func run() {
			ds.contents.filter { $0.tag == oldTag }
				.forEach {
					$0.setTag(newTag == Bookmarks.tagNullStandin ? nil : newTag)
				}
			ds.write()
		}

		func validate() throws {
			// Old tag exists
			guard
				ds.uniqueTags
					.filter({ $0 != nil })
					.map({ $0! })
					.contains(oldTag)
			else {
				exitWithError("Please specify an existing tag to update.")
			}
			// New tag has positive length
			guard newTag.hasPositiveLength() else {
				exitWithError(
					"Please specify a new tag name with positive length."
				)
			}
		}
	}

}
