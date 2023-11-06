//
//  GrilledBeefView.swift
//  FoodNutrition
//
//  Created by Minjae Kim on 11/2/23.
//

import SwiftUI

struct GrilledBeefView: View {
	
	@Binding var nutrition: Nutrition
	
	@State private var searchList: [Item] = []
	@State private var isRestaurantListSheet = false
	var body: some View {
		VStack {
			Form {
				Section {
					IngredientView(title: "갈비", amount: "2kg")
				} header: {
					Text("메인 재료")
				}
				
				Section {
					IngredientView(title: "간장", amount: "1컵반")
					IngredientView(title: "다시마우린물", amount: "5컵(맹물가능)")
					IngredientView(title: "설탕", amount: "2컵")
					IngredientView(title: "갈은 배", amount: "1/2컵(시판용가능)")
					IngredientView(title: "다진마늘", amount: "2큰술")
					IngredientView(title: "대파", amount: "1개(갈음)")
					IngredientView(title: "양파", amount: "1개(갈음)")
					IngredientView(title: "후추", amount: "1작은술")
					IngredientView(title: "참기름", amount: "4큰술")
				} header: {
					Text("양념장(재료한번에갈음)")
				}
				
				Section {
					RecipeView(imageName: "beef_1", content: "갈아만든 양념장을 준비합니다. 거기에 LA갈비를 흐르는 물에 씻은 후 바로 재우세요. LA갈비는 핏물을 안뺍니다. 뼛가루만 씻어주고 양념장에 재우면 끝!이에요. 재울때 냉동실에 바로 넣어반나절 후에 녹여 구우면 좋습니다.")
				} header: {
					Text("1")
				}
				
				Section {
					RecipeView(imageName: "beef_2", content: "이제 재웠던 LA갈비를 팬에 바로 구워도 아주 맛있고요.")
				} header: {
					Text("2")
				}
				
				Section {
					RecipeView(imageName: "beef_3", content: "오븐이 있으신 분들은 바로 오븐에 구이 메뉴로 해서 20분 구우면 딱! 좋습니다.")
				} header: {
					Text("3")
				}
				
				Section {
					RecipeView(imageName: "beef_4", content: "이건 그릴에다가 구워낸 모습입니다.")
				} header: {
					Text("4")
				}
				
				Section {
					RecipeView(imageName: "beef_5", content: "오븐에서 구운것과 팬에서 구운것을 함께 올린거예요. 차이가 없으니 편하신대로 구우셔서 맛있게드세요^^")
				} header: {
					Text("5")
				}
			}
			.navigationTitle(Text("조리법"))
		}
		.toolbar {
			Button(action: {
				self.isRestaurantListSheet.toggle()
			}) {
				Text("맛집목록")
			}
		}
		.onAppear {
			searchList = DataManager.shared.searchResult?.items ?? []
		}
		.sheet(isPresented: $isRestaurantListSheet) {
			NavigationStack {
				List {
					ForEach(0..<searchList.count, id: \.self) { i in
						NavigationLink(destination: RestaurantDetailView(restaurant: searchList[i])) {
							HStack {
								VStack(alignment: .leading) {
									Text(searchList[i].title.removeTag)
										.font(.headline)
									Text(searchList[i].roadAddress)
										.font(.caption)
										.foregroundStyle(.gray)
								}
							}
						}
					}
				}
			}
		}
	}
	struct IngredientView: View {
		
		let title: String
		let amount: String
		
		var body: some View {
			HStack {
				Text(title)
				Spacer()
				Text(amount)
			}
		}
	}
	
	struct RecipeView: View {
		
		let imageName: String
		let content: String
		
		var body: some View {
			VStack {
				Image(imageName)
					.resizable()
					.aspectRatio(contentMode: .fill)
					.padding()
				Text(content)
					.fontWeight(.bold)
					.padding()
			}
		}
	}
}

//#Preview {
//	GrilledBeefView()
//}
