import ArgumentParser
import Foundation

extension Bookmarks {

	struct Add: ParsableCommand {

		@Argument(help: "The bookmark's title")
		var title: String

		@Argument(help: "The bookmark's URL")
		var url: String

		@Option(help: "A tag for the bookmark, if you'd like one")
		var tag: String?

		func run() {

		}
	}

}
