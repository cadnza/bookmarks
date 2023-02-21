import Foundation

class Item: Decodable {

	private enum Keys: CodingKey {
		case title
		case url
		case tag
	}

	var title: String
	var url: URL
	var tag: String?

	var id: Int!

	required init(from decoder: Decoder) {
		let container = try! decoder.container(keyedBy: Keys.self)
		self.title = try! container.decode(String.self, forKey: .title)
		self.url = try! container.decode(URL.self, forKey: .url)
		self.tag = try! container.decode(String?.self, forKey: .tag)
	}

	init(title: String, url: URL, tag: String?) {
		self.title = title
		self.url = url
		self.tag = tag
	}

	func setTitle(_ title: String) {
		self.title = title
	}

	func setUrl(_ url: URL) {
		self.url = url
	}

	func setTag(_ tag: String?) {
		self.tag = tag
	}

	func setId(_ id: Int) {
		self.id = id
	}

}
