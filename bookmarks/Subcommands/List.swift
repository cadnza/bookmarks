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
				Bookmarks.exit(
					withError: ExitCodes.general(
						"No bookmarks to show"
					)
				)
			}
			if json {
				let toSerialize: [[String: Any?]] = ds.contents.map {
					[
						"id": $0.id,
						"title": $0.title,
						"url": $0.url.absoluteString,
						"tag": $0.tag,
					]
				}
				let serialized = try! JSONSerialization.data(
					withJSONObject: toSerialize,
					options: [
						.prettyPrinted, .sortedKeys, .withoutEscapingSlashes,
					]
				)
				let jsonString = String(data: serialized, encoding: .utf8)
				print(jsonString!)
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
						fputs(  // FIXME: Change all the fputs to prints
							"\(tagHeading, color: tagHeadingColor, style: .bold)\n",
							stdout
						)
						contentsCurrent
							.forEach {
								fputs(
									"\(indentSpacer)\("\($0.id!).", color: colors["id"]!, style: .bold) \($0.title)\n",
									stdout
								)
								fputs(
									"\(indentSpacer)\(indentSpacer)\($0.url, color: colors["url"]!, style: [.bold, .underlined])\n",
									stdout
								)
							}
					}
			}
		}
	}

}
