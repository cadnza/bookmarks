import ArgumentParser
import Foundation

extension Bookmarks {

	struct Add: ParsableCommand {

		@Argument(help: "The bookmark's title")
		var title: String

		@Argument(help: "The bookmark's URL")
		var url: String

		@Option(help: "A tag for the bookmark, if you'd like one")
		var tag: String?

		func run() {
			let titleTrimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
			let urlParsed = URL(string: url)!
			let tagTrimmed = tag?.trimmingCharacters(in: .whitespacesAndNewlines)
			let newItem = Item(title: titleTrimmed, url: urlParsed, tag: tagTrimmed)
			ds.contents.append(newItem)
		}

		func validate() throws {
			// Title has positive length
			guard title.trimmingCharacters(in: .whitespacesAndNewlines).count >= 1 else {
				exitWithError("Please specify a title with positive length.")
			}
			// URL is valid
			let urlErrorMessage = "Please specify a valid URL."
			let urlParsed = URL(string: url)
			guard urlParsed != nil else {
				exitWithError(urlErrorMessage)
			}
			// Tag has positive length
			if let tagU = tag {
				guard tagU.trimmingCharacters(in: .whitespacesAndNewlines).count >= 1 else {
					exitWithError("Please specify a tag with positive length.")
				}
			}
			// FIXME: Make sure title and URL are unique
		}
	}

}
