//
//  Food.swift
//  FoodNutrition
//
//  Created by Minjae Kim on 11/2/23.
//

import Foundation

struct Food: Codable {
	var nutrition: [Nutrition]
}

struct Nutrition: Codable, Identifiable {
	var id: String = UUID().uuidString
	var nutrCont8, nutrCont9, nutrCont4, nutrCont5: String
	var nutrCont6, num, nutrCont7, nutrCont1: String
	var nutrCont2, subRefName, nutrCont3, researchYear: String
	var makerName, groupName, servingSize, samplingRegionName: String
	var samplingMonthCD, samplingMonthName, descKor, samplingRegionCD: String
	var foodCD: String?
	var imageName: String
	var isStar: Bool = false
	
	enum CodingKeys: String, CodingKey {
		case nutrCont8 = "NUTR_CONT8"
		case nutrCont9 = "NUTR_CONT9"
		case nutrCont4 = "NUTR_CONT4"
		case nutrCont5 = "NUTR_CONT5"
		case nutrCont6 = "NUTR_CONT6"
		case num = "NUM"
		case nutrCont7 = "NUTR_CONT7"
		case nutrCont1 = "NUTR_CONT1"
		case nutrCont2 = "NUTR_CONT2"
		case subRefName = "SUB_REF_NAME"
		case nutrCont3 = "NUTR_CONT3"
		case researchYear = "RESEARCH_YEAR"
		case makerName = "MAKER_NAME"
		case groupName = "GROUP_NAME"
		case servingSize = "SERVING_SIZE"
		case samplingRegionName = "SAMPLING_REGION_NAME"
		case samplingMonthCD = "SAMPLING_MONTH_CD"
		case samplingMonthName = "SAMPLING_MONTH_NAME"
		case descKor = "DESC_KOR"
		case samplingRegionCD = "SAMPLING_REGION_CD"
		case foodCD = "FOOD_CD"
		case imageName = "IMAGE_NAME"
	}
}
