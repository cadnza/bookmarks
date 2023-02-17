import Foundation

extension String {

	func hasPositiveLength() -> Bool {
		!self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
	}

}
