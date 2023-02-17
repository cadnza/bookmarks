import Foundation

struct DataSource {

	let homeVar = ProcessInfo.processInfo.environment["HOME"] ?? "/"
	let configFileName = ".bookmarks"
	let configURL: URL

	let data: Data?
	let fm = FileManager.default

	var contents: [Item]

	var jsonNoIDs: String {
		buildJson(withIDs: false)
	}

	var jsonWithIDs: String {
		buildJson(withIDs: true)
	}

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
				exitWithError(
					"Can't read bookmarks; please delete '\(configURL.path)' and try again."
				)
			}
			self.contents = contentsWorking
			sortContents()
			for i in 0..<contents.count {
				let idNew = i + 1
				contents[i].setId(idNew)
			}
		} else {
			self.contents = []
		}
	}

	private mutating func sortContents() {
		self.contents = contents.sorted {
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
	}

	mutating func write() {
		sortContents()
		do {
			try jsonNoIDs.write(
				to: configURL,
				atomically: false,
				encoding: .utf8
			)
		} catch {
			print(error)
		}
	}

	private func buildJson(withIDs: Bool) -> String {
		let toSerialize: [[String: Any?]] = contents.map {
			withIDs
				? [
					"id": $0.id,
					"title": $0.title,
					"url": $0.url.absoluteString,
					"tag": $0.tag,
				]
				: [
					"title": $0.title,
					"url": $0.url.absoluteString,
					"tag": $0.tag,
				]
		}
		let serialized = try! JSONSerialization.data(
			withJSONObject: toSerialize,
			options: [
				.prettyPrinted, .sortedKeys, .withoutEscapingSlashes,
			]
		)
		let jsonString = String(data: serialized, encoding: .utf8)!
		return jsonString
	}

}
