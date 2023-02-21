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
		var ids: [Int]  // swiftlint:disable:this let_var_whitespace

		func run() {
			ds.contents = ds.contents.filter {
				!ids.contains($0.id)
			}
			ds.write()
		}

		func validate() throws {
			// IDs are valid
			let idErrorMessage =
			ids.count == 1
			? "Please specify a valid bookmark ID."
			: "One or more specified ID is invalid."
			guard
				!(ids.map { ds.contents.map { $0.id }.contains($0) }
					.contains(false))
			else {
				throw ValidationError(idErrorMessage)
			}
		}
	}

}
