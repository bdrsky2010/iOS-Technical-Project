//
//  Extension.swift
//  FoodNutrition
//
//  Created by Minjae Kim on 11/4/23.
//

import Foundation

extension String {
	var removeTag: String {
		var value: String = self
		while value.contains("<b>") {
			value = value.replacingOccurrences(of: "<b>", with: "")
		}
		while value.contains("</b>") {
			value = value.replacingOccurrences(of: "</b>", with: "")
		}
		return value
	}
	
	var stringTolatitude: Double {
		var arr: [String] = self.map { String($0) }
		arr.insert(".", at: 2)
		return Double(arr.joined()) ?? 0
	}
	
	var stringTolongitude: Double {
		var arr: [String] = self.map { String($0) }
		arr.insert(".", at: 3)
		return Double(arr.joined()) ?? 0
	}
}
