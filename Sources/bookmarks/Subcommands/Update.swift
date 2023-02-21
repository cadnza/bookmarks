import ArgumentParser
import Foundation

extension Bookmarks {

	struct Update: ParsableCommand {

		static let configuration = CommandConfiguration(
			abstract: "Updates a bookmark."
		)

		@Argument(
			help: "The ID of the bookmark to update. \(idsWarningNote)",
			completion: .custom { _ in
				completionIds
			}
		)
		var id: Int  // swiftlint:disable:this let_var_whitespace

		@Option(
			name: .shortAndLong,
			help: "The bookmark's new title.",
			completion: nil
		)
		var Title: String?  // swiftlint:disable:this let_var_whitespace

		@Option(
			name: .shortAndLong,
			help: "The bookmark's new URL.",
			completion: nil
		)
		var url: String?  // swiftlint:disable:this let_var_whitespace

		@Option(
			name: .shortAndLong,
			help:
				"The bookmark's new tag, or '\(tagNullStandin)' to remove the current tag.",
			completion: .custom { _ in
				completionTagsWithNull
			}
		)
		var tag: String?  // swiftlint:disable:this let_var_whitespace

		func run() {
			let itemCurrent = ds.contents.first { $0.id == id }
			if let titleU = Title {
				itemCurrent!.setTitle(titleU)
			}
			if let urlU = url {
				itemCurrent!.setUrl(URL(string: urlU)!)
			}
			if let tagU = tag {
				itemCurrent!
					.setTag(
						tagU == tagNullStandin ? nil : tagU
					)
			}
			ds.write()
		}

		func validate() throws {
			// ID is valid
			guard ds.contents.map({ $0.id }).contains(id) else {
				throw ValidationError("Please specify a valid bookmark ID.")
			}
			// At least one update parameter is specified
			guard [Title, url, tag].map({ $0 != nil }).contains(true) else {
				throw ValidationError(
					"Please specify at least one parameter to update."
				)
			}
			// Title
			if let titleU = Title {
				// Title has positive length
				guard titleU.hasPositiveLength() else {
					throw ValidationError(
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
					throw ValidationError("A bookmark by that title already exists.")
				}
				// Title has changed
				guard ds.contents.first(where: { $0.id == id })!.title != Title
				else {
					throw ValidationError(
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
					throw ValidationError(urlErrorMessage)
				}
				// URL is unique
				guard
					!ds.contents
						.filter({ $0.id != id })
						.map({ $0.url.absoluteString })
						.contains(urlU)
				else {
					throw ValidationError("A bookmark to that URL already exists.")
				}
				// URL has changed
				guard
					ds.contents.first(where: { $0.id == id })!.url
						.absoluteString != url
				else {
					throw ValidationError(
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
					throw ValidationError("Please specify a tag with positive length.")
				}
				// Tag has changed
				guard ds.contents.first(where: { $0.id == id })!.tag != tag
				else {
					throw ValidationError(
						"Tag has not changed and will not be updated."
					)
				}
			}
		}
	}

}
