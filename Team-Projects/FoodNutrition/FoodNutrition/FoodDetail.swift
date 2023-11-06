//
//  DumplingSoupView.swift
//  FoodNutrition
//
//  Created by Minjae Kim on 11/2/23.
//

import SwiftUI

struct FoodDetail: View {
	
	@Binding var selectedFood: Nutrition
	@State private var requestApi = LoadRestaurantAPI()
	
	var body: some View {
		Form {
			Section {
				Image(selectedFood.imageName)
					.resizable()
					.clipShape(.rect(cornerRadius: 12.0))
					.aspectRatio(contentMode: .fit)
					.padding()
				
				HStack {
					Text(selectedFood.descKor)
						.font(.headline)
					Spacer()
					Button(action: toggledStar) {
						selectedFood.isStar ? Image(systemName: "star.fill").foregroundStyle(.yellow) : Image(systemName: "star.fill").foregroundStyle(.gray)
					}
				}
				
				HStack {
					Text("총 내용량")
					Spacer()
					Text(selectedFood.servingSize)
				}
				
				HStack {
					Text("열량(kcal)(1회 제공량당)")
					Spacer()
					Text(selectedFood.nutrCont1)
				}
				
				HStack {
					Text("탄수화물(g)(1회제공량당)")
					Spacer()
					Text(selectedFood.nutrCont2)
				}
				
				HStack {
					Text("단백질(g) (1회제공량당)")
					Spacer()
					Text(selectedFood.nutrCont3)
				}
				
				HStack {
					Text("지방(g)(1회제공량당)")
					Spacer()
					Text(selectedFood.nutrCont4)
				}
				
				HStack {
					Text("당류(g)(1회제공량당)")
					Spacer()
					Text(selectedFood.nutrCont5)
				}
				
				HStack {
					Text("나트륨(mg)(1회제공량당)")
					Spacer()
					Text(selectedFood.nutrCont6)
				}
				
				HStack {
					Text("콜레스테롤(mg)(1회제공량당)")
					Spacer()
					Text(selectedFood.nutrCont7)
				}
				
				HStack {
					Text("포화지방산(g) (1회제공량당)")
					Spacer()
					Text(selectedFood.nutrCont8)
				}
				
				HStack {
					Text("트랜스지방(g) (1회제공량당)")
					Spacer()
					Text(selectedFood.nutrCont9)
				}
			}
			.navigationTitle(Text("영양성분"))
		}
		.toolbar {
			NavigationLink(destination: {
				switch selectedFood.descKor {
				case "닭갈비":
					ChickenRibsView(nutrition: $selectedFood)
				case "소양념갈비구이":
					GrilledBeefView(nutrition: $selectedFood)
				case "양념장어구이":
					SeasonedGrilledEelView(nutrition: $selectedFood)
				case "햄버그스테이크":
					HamburgerSteakView(nutrition: $selectedFood)
				case "굴국밥":
					OysterGukbapView(nutrition: $selectedFood)
				case "떡만둣국":
					DumplingSoupView(nutrition: $selectedFood)
				default:
					Text("에러다;;")
				}
			}) {
				Text("Next")
			}
			.onAppear {
				requestApi.requestAPIToNaver(queryValue: "소양념갈비")
			}
		}
	}
	func toggledStar() {
		selectedFood.isStar.toggle()
	}
}

//#Preview {
//	DumplingSoupView(selectedFood: foodData.nutrition[5])
//}
