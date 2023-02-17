import ArgumentParser
import Foundation

extension Bookmarks {

	struct Update: ParsableCommand {

		static let tagNullStandin = "NULL"

		@Argument(help: "The ID of the bookmark to update \(idsWarningNote)")
		var id: Int

		@Option(help: "The bookmark's new title")
		var title: String?

		@Option(help: "The bookmark's new URL")
		var url: String?

		@Option(
			help:
				"The bookmark's new tag, or \(Bookmarks.Update.tagNullStandin) to remove the current tag"
		)
		var tag: String?  // swiftlint:disable:this let_var_whitespace

		func run() {
			var itemCurrent = ds.contents.first { $0.id == id }
			if let titleU = title {
				itemCurrent!.setTitle(titleU)
			}
			if let urlU = url {
				itemCurrent!.setUrl(URL(string: urlU)!)
			}
			if let tagU = tag {
				itemCurrent!
					.setTag(
						tagU == Bookmarks.Update.tagNullStandin ? nil : tagU
					)
			}
			ds.write()
		}

		func validate() throws {
			// ID is valid
			guard ds.contents.map({ $0.id }).contains(id) else {
				exitWithError("Please specify a valid bookmark ID.")
			}
			// At least one update parameter is specified
			guard [title, url, tag].map({ $0 != nil }).contains(true) else {
				exitWithError(
					"Please specify at least one parameter to update."
				)
			}
			// Title
			if let titleU = title {
				// Title has positive length
				guard titleU.hasPositiveLength() else {
					exitWithError(
						"Please specify a title with positive length."
					)
				}
				// Title is unique
				guard
					!ds.contents
						.filter({ $0.id != id })
						.map({ $0.title })
						.contains(titleU)
				else {
					exitWithError("A bookmark by that title already exists.")
				}
				// Title has changed
				guard ds.contents.first(where: { $0.id == id })!.title != title
				else {
					exitWithError(
						"Title has not changed and will not be updated."
					)
				}
			}
			// URL
			if let urlU = url {
				// URL is valid
				let urlErrorMessage = "Please specify a valid URL."
				let urlParsed = URL(string: urlU)
				guard urlParsed != nil else {
					exitWithError(urlErrorMessage)
				}
				// URL is unique
				guard
					!ds.contents
						.filter({ $0.id != id })
						.map({ $0.url.absoluteString })
						.contains(urlU)
				else {
					exitWithError("A bookmark to that URL already exists.")
				}
				// URL has changed
				guard
					ds.contents.first(where: { $0.id == id })!.url
						.absoluteString != url
				else {
					exitWithError(
						"URL has not changed and will not be updated."
					)
				}
			}
			// Tag
			if let tagU = tag {
				// Tag has positive length
				guard
					tagU.hasPositiveLength()
				else {
					exitWithError("Please specify a tag with positive length.")
				}
				// Tag has changed
				guard ds.contents.first(where: { $0.id == id })!.tag != tag
				else {
					exitWithError(
						"Tag has not changed and will not be updated."
					)
				}
			}
		}
	}

}
