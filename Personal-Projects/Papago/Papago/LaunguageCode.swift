//
//  LaunguageCode.swift
//  Papago
//
//  Created by Minjae Kim on 11/15/23.
//

import Foundation

enum LaunguageCode: String, CaseIterable {
	case korean = "ko"
	case english = "en"
	case japanese = "ja"
	case simplifiedChinese = "za-CN"
	case traditionalChinese = "zh-TW"
	case vietnamese = "vi"
	case indonesian = "id"
	case thai = "th"
	case german = "de"
	case russian = "ru"
	case spanish = "es"
	case italian = "it"
	case french = "fr"
	
	var language: String {
		switch self {
		case .korean:
			return "한국어"
		case .english:
			return "영어"
		case .japanese:
			return "일본어"
		case .simplifiedChinese:
			return "중국어(간체)"
		case .traditionalChinese:
			return "중국어(번체)"
		case .vietnamese:
			return "베트남어"
		case .indonesian:
			return "인도네시아어"
		case .thai:
			return "태국어"
		case .german:
			return "독일어"
		case .russian:
			return "러시아어"
		case .spanish:
			return "스페인어"
		case .italian:
			return "이탈리아어"
		case .french:
			return "프랑스어"
		}
	}
}

struct Language: Hashable {
	let languageCode: LaunguageCode
	let language: String
	var isSource: Bool = false
	var isTarget: Bool = false
}
