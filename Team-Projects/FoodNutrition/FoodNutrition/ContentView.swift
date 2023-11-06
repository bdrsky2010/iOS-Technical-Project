//
//  ContentView.swift
//  FoodNutrition
//
//  Created by Minjae Kim on 11/2/23.
//

import SwiftUI

struct ContentView: View {
	
	@StateObject var foodStore: FoodStore = FoodStore(food: foodData)
	
	var body: some View {
		NavigationStack {
			List(0..<foodStore.food.nutrition.count, id: \.self) { i in
				NavigationLink(destination: { FoodDetail(selectedFood: $foodStore.food.nutrition[i]) }) {
					HStack {
						FoodListCell(imageName: foodStore.food.nutrition[i].imageName, foodName: foodStore.food.nutrition[i].descKor, isStar: foodStore.food.nutrition[i].isStar)
					}
				}
			}
			.toolbar {
				StarButton().environmentObject(foodStore)
			}
			.navigationTitle(Text("음식"))
		}
	}
	
	struct StarButton: View {
		
		@EnvironmentObject var foodStore: FoodStore
		
		var body: some View {
			NavigationLink(destination: StarListView().environmentObject(foodStore)) {
				Image(systemName: "star.fill")
					.resizable()
					.foregroundStyle(.yellow)
			}
		}
	}
}

#Preview {
	ContentView()
}

struct FoodListCell: View {
	let imageName: String
	let foodName: String
	let isStar: Bool
	
	var body: some View {
		HStack{
			Image(imageName)
				.resizable()
				.aspectRatio(contentMode: .fill)
				.frame(width: 100, height: 60)
				.clipShape(.rect(cornerRadius: 6.0))
			Text(foodName)
			Spacer()
			isStar ? Image(systemName: "star.fill").foregroundStyle(.yellow) : Image(systemName: "star.fill").foregroundStyle(.gray)
		}
	}
}
