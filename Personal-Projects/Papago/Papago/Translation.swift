//
//  Translation.swift
//  Papago
//
//  Created by Minjae Kim on 11/13/23.
//

import Foundation

struct Translation: Decodable {
	let message: Message
}

struct Message: Decodable {
	let type: String
	let service: String
	let version: String
	let result: Result
	
	enum CodingKeys: String, CodingKey {
		case type = "@type"
		case service = "@service"
		case version = "@version"
		case result
	}
}

struct Result: Decodable {
	let srcLangType: String
	let tarLangType: String
	let translatedText: String
}
