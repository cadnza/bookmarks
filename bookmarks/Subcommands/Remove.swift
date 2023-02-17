import ArgumentParser
import Foundation

extension Bookmarks {

	struct Remove: ParsableCommand {

		@Argument(help: "The ID of the bookmark to remove \(idsWarningNote)")
		var id: Int

		func run() {
			ds.contents = ds.contents.filter {
				$0.id != id
			}
		}

		func validate() throws {
			guard ds.contents.map({ $0.id }).contains(id) else {
				exitWithError("Please specify a valid bookmark ID.")
			}
		}
	}

}
