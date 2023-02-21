import ArgumentParser
import Foundation

extension Bookmarks {

	struct Update: ParsableCommand {

		static let configuration = CommandConfiguration(
			abstract: "Updates a bookmark."
		)

		@Argument(
			help: "One or more IDS to update. \(idsWarningNote)",
			completion: .custom { _ in
				completionIds
			}
		)
		var ids: [Int]  // swiftlint:disable:this let_var_whitespace

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
			let itemsCurrent = ds.contents.filter { ids.contains($0.id) }
			if let titleU = Title {
				itemsCurrent[0].setTitle(titleU)
			}
			if let urlU = url {
				itemsCurrent[0].setUrl(URL(string: urlU)!)
			}
			if let tagU = tag {
				itemsCurrent.forEach {
					$0.setTag(
						tagU == tagNullStandin ? nil : tagU
					)
				}
			}
			ds.write()
		}

		func validate() throws {
			// IDs are valid
			let idErrorMessage =
				ids.count == 1
				? "Please specify a valid bookmark ID."
				: "One or more specified ID is invalid."
			guard
				!(ids.map { ds.contents.map { $0.id }.contains($0) }
					.contains(false))
			else {
				throw ValidationError(idErrorMessage)
			}
			// At least one update parameter is specified
			guard [Title, url, tag].map({ $0 != nil }).contains(true) else {
				throw ValidationError(
					"Please specify at least one parameter to update."
				)
			}
			// One and only one ID unless only updating tags
			guard (Title == nil && url == nil && tag != nil) || (ids.count == 1)
			else {
				throw ValidationError(
					"Updating multiple IDs is only allowed if only updating tag."
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
						.filter({ !ids.contains($0.id) })
						.map({ $0.title })
						.contains(titleU)
				else {
					throw ValidationError(
						"A bookmark by that title already exists."
					)
				}
				// Title has changed
				guard
					ds.contents.first(where: { $0.id == ids[0] })!.title
						!= Title
				else {
					throw ValidationError(
						"Title has not changed; this item was not updated."
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
						.filter({ !ids.contains($0.id) })
						.map({ $0.url.absoluteString })
						.contains(urlU)
				else {
					throw ValidationError(
						"A bookmark to that URL already exists."
					)
				}
				// URL has changed
				guard
					ds.contents.first(where: { $0.id == ids[0] })!.url
						.absoluteString != url
				else {
					throw ValidationError(
						"URL has not changed; this item was not updated."
					)
				}
			}
			// Tag
			if let tagU = tag {
				// Tag has positive length
				guard
					tagU.hasPositiveLength()
				else {
					throw ValidationError(
						"Please specify a tag with positive length."
					)
				}
				// At least one tag has changed
				let tagErrorMessage =
					ids.count == 1
					? "Tag has not changed; this item was not updated."
					: "No tags have changed; these items were not updated."
				let allTagsSame =
					!(ds.contents
					.filter { ids.contains($0.id) }
					.map { $0.tag }
					.map { $0 == nil ? Bookmarks.tagNullStandin : $0! }
					.map { $0 == tag }
					.contains(false))
				guard !allTagsSame else {
					throw ValidationError(tagErrorMessage)
				}
			}
		}
	}

}
