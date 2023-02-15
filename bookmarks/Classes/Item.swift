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

}
