import ArgumentParser
import Foundation

extension Bookmarks {

	struct Update: ParsableCommand {

		@Argument(help: "The ID of the bookmark to update \(idsWarningNote)")
		var id: Int

		@Option(help: "The bookmark's new title")
		var title: String?

		@Option(help: "The bookmark's new URL")
		var url: String?

		@Option(
			help: "The bookmark's new tag, or NULL to remove the current tag"
		)
		var tag: String?

		func run() {
			// TODO
		}

		func validate() throws {
			// At least one update parameter is specified
			guard [title, url, tag].map({ $0 != nil }).contains(true) else {
				exitWithError(
					"Please specify at least one parameter to update."
				)
			}
			// Title has positive length
			if let titleU = title {
				guard titleU.hasPositiveLength() else {
					exitWithError(
						"Please specify a title with positive length."
					)
				}
			}
			// URL is valid
			if let urlU = url {
				let urlErrorMessage = "Please specify a valid URL."
				let urlParsed = URL(string: urlU)
				guard urlParsed != nil else {
					exitWithError(urlErrorMessage)
				}
			}
			// Tag has positive length
			if let tagU = tag {
				guard
					tagU.hasPositiveLength()
				else {
					exitWithError("Please specify a tag with positive length.")
				}
			}
			// Title is unique
			if let titleU = title {
				guard
					!ds.contents.filter({ $0.id != id }).map({ $0.title })
						.contains(titleU)
				else {
					exitWithError("A bookmark by that title already exists.")
				}
			}
			// URL is unique
			if let urlU = url {
				guard
					!ds.contents.filter({ $0.id != id })
						.map({ $0.url.absoluteString }).contains(urlU)
				else {
					exitWithError("A bookmark to that URL already exists.")
				}
			}
		}
	}

}
