//
//  OysterGukbapView.swift
//  FoodNutrition
//
//  Created by Minjae Kim on 11/2/23.
//

import SwiftUI

struct OysterGukbapView: View {
	
	@Binding var nutrition: Nutrition
	
	var body: some View {
		Text(nutrition.descKor)
        Link("굴 축제 정보", destination: URL(string:"https://www.brcn.go.kr/tour/sub03_01_01.do")! )
	}
}

//#Preview {
//	OysterGukbapView()
//}
