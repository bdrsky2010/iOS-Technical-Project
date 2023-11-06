//
//  StarListView.swift
//  FoodNutrition
//
//  Created by Minjae Kim on 11/2/23.
//

import SwiftUI

struct StarListView: View {
	
	@EnvironmentObject var foodStore: FoodStore
	
	var body: some View {
		List(0..<foodStore.food.nutrition.count, id: \.self) { i in
			if foodStore.food.nutrition[i].isStar {
				NavigationLink(destination: { FoodDetail(selectedFood: $foodStore.food.nutrition[i]) }) {
					HStack {
						FoodListCell(imageName: foodStore.food.nutrition[i].imageName, foodName: foodStore.food.nutrition[i].descKor, isStar: foodStore.food.nutrition[i].isStar)
					}
				}
			}
		}
		.navigationTitle(Text("즐겨찾기"))
	}
}

//#Preview {
//	StarListView()
//}
