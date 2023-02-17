import ArgumentParser
import Chalk
import Foundation

func exitWithError(_ message: String, _ code: Int32 = 1) -> Never {
	let colorError = Color.red
	fputs(
		"\(message, color: colorError)\n",
		stderr
	)
	Bookmarks.exit(
		withError: ExitCode(code)
	)
}
