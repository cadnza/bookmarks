import ArgumentParser
import Chalk
import Foundation

extension Bookmarks {

	struct List: ParsableCommand {

		static let configuration = CommandConfiguration(
			abstract: "Lists all bookmarks."
		)

		@Flag(name: .shortAndLong, help: "Show output as JSON.")
		private var json = false

		func run() {
			guard !ds.contents.isEmpty else {
				exitWithError("No bookmarks to show.")
			}
			if json {
				print(ds.jsonWithIDs)
			} else {
				ds.uniqueTags
					.forEach {
						var contentsCurrent: [Item]
						var tagHeading: String
						var tagHeadingColor: Color
						if let tagU = $0 {
							contentsCurrent = ds.contents.filter {
								$0.tag == tagU
							}
							tagHeading = tagU
							tagHeadingColor = colors["tag"]!
						} else {
							contentsCurrent = ds.contents.filter {
								$0.tag == nil
							}
							tagHeading = untaggedHeading
							tagHeadingColor = colors["noTag"]!
						}
						print(
							"\(tagHeading, color: tagHeadingColor, style: .bold)"
						)
						contentsCurrent
							.forEach {
								print(
									"\(indentSpacer)\("\($0.id!).", color: colors["id"]!, style: .bold) \($0.title)"
								)
								print(
									"\(indentSpacer)\(indentSpacer)\($0.url, color: colors["url"]!, style: [.underlined])"
								)
							}
					}
			}
		}
	}

}