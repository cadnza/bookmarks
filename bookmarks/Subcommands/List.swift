import ArgumentParser
import Chalk
import Foundation

extension Bookmarks {

	struct List: ParsableCommand {

		static let configuration = CommandConfiguration(
			abstract: "List all bookmarks"
		)

		@Flag(name: .shortAndLong, help: "Show output as JSON.")
		private var json = false

		private var untaggedHeading = "Untagged"
		private var indentSpacer = "  "

		func run() {
			guard !ds.contents.isEmpty else {
				exitWithError("No bookmarks to show.")
			}
			if json {
				print(ds.jsonWithIDs)
			} else {
				(ds.contents.map { $0.tag }
					.reduce(into: []) { result, x in
						if !result.contains(where: { e in
							e as? String == x
						}) {
							result.append(x as Any)
						}
					} as! [String?])
					.forEach {
						var contentsCurrent: [Item]
						var tagHeading: String
						var tagHeadingColor: Color
						if let tagU = $0 {
							contentsCurrent = ds.contents.filter {
								$0.tag == tagU
							}
							tagHeading = tagU
							tagHeadingColor = Bookmarks.colors["tag"]!
						} else {
							contentsCurrent = ds.contents.filter {
								$0.tag == nil
							}
							tagHeading = untaggedHeading
							tagHeadingColor = Bookmarks.colors["noTag"]!
						}
						print(
							"\(tagHeading, color: tagHeadingColor, style: .bold)"
						)
						contentsCurrent
							.forEach {
								print(
									"\(indentSpacer)\("\($0.id!).", color: Bookmarks.colors["id"]!, style: .bold) \($0.title)"
								)
								print(
									"\(indentSpacer)\(indentSpacer)\($0.url, color: Bookmarks.colors["url"]!, style: [.bold, .underlined])"
								)
							}
					}
			}
		}
	}

}
