import ArgumentParser
import Foundation

extension Bookmarks {

	struct Add: ParsableCommand {

		static let configuration = CommandConfiguration(
			abstract: "Adds a new bookmark."
		)

		@Argument(help: "The bookmark's title.", completion: nil)
		var Title: String

		@Argument(help: "The bookmark's URL.", completion: nil)
		var url: String

		@Option(
			name: .shortAndLong,
			help: "A tag for the bookmark, if you'd like one.",
			completion: .custom { _ in
				completionTags
			}
		)
		var tag: String?  // swiftlint:disable:this let_var_whitespace

		func run() {
			let titleTrimmed = Title.trimmingCharacters(
				in: .whitespacesAndNewlines
			)
			let urlParsed = URL(string: url)!
			let tagTrimmed = tag?
				.trimmingCharacters(in: .whitespacesAndNewlines)
			let newItem = Item(
				title: titleTrimmed,
				url: urlParsed,
				tag: tagTrimmed
			)
			ds.contents.append(newItem)
			ds.write()
		}

		func validate() throws {
			// Title has positive length
			guard
				Title.hasPositiveLength()
			else {
				throw ValidationError("Please specify a title with positive length.")
			}
			// URL is valid
			let urlErrorMessage = "Please specify a valid URL."
			let urlParsed = URL(string: url)
			guard urlParsed != nil else {
				throw ValidationError(urlErrorMessage)
			}
			// Tag has positive length
			if let tagU = tag {
				guard
					tagU.hasPositiveLength()
				else {
					throw ValidationError("Please specify a tag with positive length.")
				}
			}
			// Title is unique
			guard !ds.contents.map({ $0.title }).contains(Title) else {
				throw ValidationError("A bookmark by that title already exists.")
			}
			// URL is unique
			guard !ds.contents.map({ $0.url.absoluteString }).contains(url)
			else {
				throw ValidationError("A bookmark to that URL already exists.")
			}
		}
	}

}
