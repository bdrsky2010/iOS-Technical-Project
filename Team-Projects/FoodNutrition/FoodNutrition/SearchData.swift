//
//  SearchData.swift
//  FoodNutrition
//
//  Created by Minjae Kim on 11/2/23.
//

import Foundation

class DataManager {
	static let shared: DataManager = DataManager()
	var searchResult: Search?
}

class LoadRestaurantAPI {
	
	static var shared = LoadRestaurantAPI()
	
	let jsconDecoder: JSONDecoder = JSONDecoder()
	
	func urlTaskDone() {
		print(DataManager.shared.searchResult?.items ?? [])
	}
	
	func requestAPIToNaver(queryValue: String) {
		
		let clientID: String = Secret().naverClientID
		let clientKEY: String = Secret().naverClientSecret
		
		let query: String  = "https://openapi.naver.com/v1/search/local.json?query=\(queryValue)&display=20&start=1&sort=comment"
		let encodedQuery: String = query.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
		let queryURL: URL = URL(string: encodedQuery)!
		var requestURL = URLRequest(url: queryURL)
		requestURL.addValue(clientID, forHTTPHeaderField: "X-Naver-Client-Id")
		requestURL.addValue(clientKEY, forHTTPHeaderField: "X-Naver-Client-Secret")
		
		let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
			guard error == nil else { print(error as Any); return }
			guard let data = data else { print(error as Any); return }
			do {
				let searchInfo: Search = try self.jsconDecoder.decode(Search.self, from: data)
				DataManager.shared.searchResult = searchInfo
				self.urlTaskDone()
			} catch {
				print("에러다")
			}
		}
		task.resume()
	}
}
