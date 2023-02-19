import ArgumentParser
import Chalk
import Foundation

extension Bookmarks {

	struct ListTags: ParsableCommand {

		static let configuration = CommandConfiguration(
			abstract: "List all tags"
		)

		@Flag(name: .shortAndLong, help: "Show output as JSON.")
		private var json = false

		func run() {
			guard !ds.contents.isEmpty else {
				exitWithError("No bookmarks to show.")
			}
			if json {
				let toSerialize: [[String: Any?]] =
					ds.uniqueTags
					.map { t in
						[
							"tag": t,
							"count": ds.contents
								.filter { c in
									c.tag == t
								}
								.count,
						]
					}
				let serialized = try! JSONSerialization.data(
					withJSONObject: toSerialize,
					options: [
						.prettyPrinted, .sortedKeys, .withoutEscapingSlashes,
					]
				)
				let jsonString = String(data: serialized, encoding: .utf8)!
				print(jsonString)
			} else {
				ds.uniqueTags.forEach { t in
					let tagTitle = (t == nil ? Bookmarks.untaggedHeading : t)!
					let ct = ds.contents.filter { $0.tag == t }.count
					let printColor = t == nil ? colors["noTag"]! : colors["tag"]!
					print("\(tagTitle, color: printColor, style: [.bold])")
					print("\(indentSpacer)\(ct, style: .bold) bookmarks")
				}
			}
		}
	}

}
