import ArgumentParser
import Foundation

extension Bookmarks {

	struct List: ParsableCommand {

		@Flag(help: "Show output as JSON")
		var json = false

		var untaggedHeading = "*Untagged*"
		var indentSpacer = "\t"

		func run() {
			// TODO: What if there are no bookmarks?
			if json {
				// FIXME: Write logic for JSON output
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
						if let tagU = $0 {
							contentsCurrent = ds.contents.filter {
								$0.tag == tagU
							}
							tagHeading = tagU
						} else {
							contentsCurrent = ds.contents.filter {
								$0.tag == nil
							}
							tagHeading = untaggedHeading
						}
						print(tagHeading)
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
