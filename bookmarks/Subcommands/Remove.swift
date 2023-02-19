import ArgumentParser
import Foundation

extension Bookmarks {

	struct Remove: ParsableCommand {

		static let configuration = CommandConfiguration(
			abstract: "Removes a bookmark."
		)

		@Argument(
			help: "The ID of the bookmark to remove. \(idsWarningNote)",
			completion: .custom { _ in
				completionIds
			}
		)
		var id: Int  // swiftlint:disable:this let_var_whitespace

		func run() {
			ds.contents = ds.contents.filter {
				$0.id != id
			}
		}

		func validate() throws {
			// ID is valid
			guard ds.contents.map({ $0.id }).contains(id) else {
				exitWithError("Please specify a valid bookmark ID.")
			}
		}
	}

}
