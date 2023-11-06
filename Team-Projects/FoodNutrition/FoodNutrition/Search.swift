import Foundation

// MARK: - Restaurant
struct Search: Codable {
		let lastBuildDate: String
		let total, start, display: Int
		let items: [Item]
}

// MARK: - Item
struct Item: Codable {
		let title: String
		let link: String
		let category, description, telephone, address: String
		let roadAddress, mapx, mapy: String
}
