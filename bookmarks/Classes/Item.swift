import Foundation

struct Item: Decodable {

	private enum Keys: CodingKey {
		case title
		case url
		case tag
	}

	let title: String
	let url: URL
	let tag: String?

	var id: Int!

	init(from decoder: Decoder) {
		let container = try! decoder.container(keyedBy: Keys.self)
		self.title = try! container.decode(String.self, forKey: .title)
		self.url = try! container.decode(URL.self, forKey: .url)
		self.tag = try! container.decode(String?.self, forKey: .tag)
	}

	mutating func setId(_ id: Int) {
		self.id = id
	}

}
