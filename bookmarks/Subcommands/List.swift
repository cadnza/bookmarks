import ArgumentParser
import Chalk
import Foundation

extension Bookmarks {

	struct List: ParsableCommand {

		@Flag(help: "Show output as JSON")
		private var json = false

		private var untaggedHeading = "*Untagged*"
		private var indentSpacer = "\t"

		func run() {
			// TODO: What if there are no bookmarks?
			if json {
				// FIXME: Write logic for JSON output
			} else {
				let colors: [String: Color] = [
					"noTag": .red,
					"tag": .green
				]
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
						fputs(
							"\(tagHeading, color: tagHeadingColor, style: .bold)\n",
							stdout
						)
						contentsCurrent
							.forEach {
								print("\(indentSpacer)\($0.title)")
								print("\(indentSpacer)\($0.url)")
							}
					}
			}
		}
	}

}
