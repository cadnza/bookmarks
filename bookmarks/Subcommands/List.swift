import ArgumentParser
import Chalk
import Foundation

extension Bookmarks {

	struct List: ParsableCommand {

		@Flag(help: "Show output as JSON")
		private var json = false

		private var untaggedHeading = "Untagged"
		private var indentSpacer = "  "

		func run() {
			let colors: [String: Color] = [
				"noTag": .red,
				"tag": .green,
				"url": .blue,
				"error": .red,
				"id": .magenta,
			]
			guard !ds.contents.isEmpty else {
				exitWithError("No bookmarks to show.")
			}
			if json {
				print(ds.json)
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
									"\(indentSpacer)\(indentSpacer)\($0.url, color: colors["url"]!, style: [.bold, .underlined])"
								)
							}
					}
			}
		}
	}

}
