import ArgumentParser
import Foundation

extension Bookmarks {

	struct List: ParsableCommand {

		@Flag(help: "Show output as JSON")
		var json = false

		var untaggedHeading = "*Untagged*"
		var indentSpacer = "\t"

		func run() {
			if json {
				// FIXME: Write logic for JSON output
			} else {
				Array(Set(ds.contents.map { $0.tag }))
					.sorted {
						guard let u1 = $0 else {
							return true
						}
						guard let u2 = $1 else {
							return false
						}
						return u1 < u2
					}
					.forEach {
						var currentItems: [Item]
						var tagHeading: String
						if let tagU = $0 {
							currentItems = ds.contents.filter {
								$0.tag == tagU
							}
							tagHeading = tagU
						} else {
							currentItems = ds.contents.filter {
								$0.tag == nil
							}
							tagHeading = untaggedHeading
						}
						print(tagHeading)
						currentItems.sorted {
							$0.title < $1.title
						}
						.forEach {
							print("\(indentSpacer)\($0.title)")
						}
					}
			}
		}
	}

}
