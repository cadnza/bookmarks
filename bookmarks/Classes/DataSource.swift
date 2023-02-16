import Foundation

struct DataSource {

	enum Errors: Error {
		case cantParseConfig
	}

	let homeVar = ProcessInfo.processInfo.environment["HOME"] ?? "/"
	let configFileName = ".bookmarks"
	let configURL: URL

	let data: Data?
	let fm = FileManager.default

	let contents: [Item]

	init() throws {
		// Set path to config
		self.configURL = URL(fileURLWithPath: homeVar)
			.appendingPathComponent(configFileName)
		// Read in contents
		self.data = try? Data(contentsOf: configURL)
		if let dataU = data {
			guard
				let contentsWorking = try? JSONDecoder()
					.decode([Item].self, from: dataU)
			else {
				fputs(
					"Can't read bookmarks; please delete '\(configURL.path)' and try again.",
					stderr
				)
				throw Errors.cantParseConfig
			}
			self.contents = contentsWorking.sorted {
				guard let tagLU = $0.tag, let tagRU = $1.tag else {
					if $0.tag == $1.tag {
						return $0.title < $1.title
					}
					return $0.tag == nil
				}
				guard tagLU == tagRU else {
					return tagLU < tagRU
				}
				return $0.title < $1.title
			}
		} else {
			self.contents = []
		}
	}

}
