//
//  SeasonedGrilledEelView.swift
//  FoodNutrition
//
//  Created by Minjae Kim on 11/2/23.
//

import SwiftUI

struct SeasonedGrilledEelView: View {
    
    @State var ing2: [String:String] = ["eel": "1마리", "oil": "1T", "salt": "조금", "red_pepper_paste": "2T", "soy_sauce": "1T", "red_pepper_powder": "1T", "minced_garlic": "1T", "wine": "1T", "sugar": "1T", "oligosaccharide": "1T"
    ]
    
	@Binding var nutrition: Nutrition
	
	var body: some View {
        VStack {
            Form {
                Section{
                    Image("3")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10.0)
                } header: {
                    Text("양념장어구이")
                }
                Section {
                    IngredientView(ing: ing2["eel"] ?? "", title:"장어")
                    IngredientView(ing: ing2["oil"] ?? "", title:"식용유")
                    IngredientView(ing: ing2["salt"] ?? "", title:"소금")
                } header: {
                    Text("메인 재료")
                }
                Section {
                    IngredientView(ing: ing2["red_pepper_paste"] ?? "", title:"고추장")
                    IngredientView(ing: ing2["soy_sauce"] ?? "", title:"간장")
                    IngredientView(ing: ing2["red_pepper_powder"] ?? "", title:"고춧가루")
                    IngredientView(ing: ing2["minced_garlic"] ?? "", title:"다진마늘")
                    IngredientView(ing: ing2["wine"] ?? "", title:"와인")
                    IngredientView(ing: ing2["sugar"] ?? "", title:"설탕")
                    IngredientView(ing: ing2["oligosaccharide"] ?? "", title:"올리고당")
                } header: {
                    Text("소스 재료")
                }
                Section {
                    VStack(alignment: .leading) {
                        TextView(num: "1.", text: "손질된 장어는 핏물을 제거하고 식용유 두른 팬에 올립니다. 소금도 약간 뿌려주세요.")
                        TextView(num: "2.", text: "앞뒤로 노릇하게 구워주세요.")
                        TextView(num: "3.", text: "소스 재료를 잘 섞어주세요.")
                        TextView(num: "4.", text: "한번 바글바글 끓여줍니다.")
                        TextView(num: "5.", text: "구운 장어 위에 양념장을 듬뿍 발라주세요.")
                        TextView(num: "6.", text: "앞뒤로 양념을 덧발라가며 구워줍니다.")
                    }
                } header: {
                    Text("요리법")
                }
                
            }
            .navigationTitle("Recipe")
        }
	}
}

struct IngredientView: View {
    var ing: String
    var title: String
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(ing)
        }
    }
}

struct TextView: View {
    var num: String
    var text: String
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(num)
                .fontWeight(.bold)
            Text(text)
        }
        .padding(.bottom, 10)
    }
}

#Preview {
    @StateObject var foodStore: FoodStore = FoodStore(food: foodData)
    return SeasonedGrilledEelView(nutrition: $foodStore.food.nutrition[2])
}
