//
//  ChickenRibsView.swift
//  FoodNutrition
//
//  Created by Minjae Kim on 11/2/23.
//

import SwiftUI
import Charts

struct ChickenRibsView: View {
	
	@Binding var nutrition: Nutrition
    @State private var foodTemp: [(name: String, count: Int)] = []
	var body: some View {
		Text(nutrition.descKor)
            .onAppear {
                foodTemp = [
                    (name: "탄수화물", count: Int(Double(nutrition.nutrCont2) ?? 0 )),
                    (name: "단백질", count: Int(Double(nutrition.nutrCont3) ?? 0 )),
                    (name: "지방", count: Int(Double(nutrition.nutrCont4) ?? 0 )),
                    (name: "당류", count: Int(Double(nutrition.nutrCont5) ?? 0 ))
                ]
                print(nutrition.nutrCont2)
                print(foodTemp)
            }
        Form {
            Section(header: Text("맛있겠쥐?")) {
                Image(._1)
                    .resizable()
                    .cornerRadius(12.0)
                    .aspectRatio(contentMode: .fit)
                    .padding()
                
                Text(nutrition.descKor)
                    .font(.headline)
                VStack(alignment: .leading){
                    Text("\(nutrition.servingSize)g 기준")
                        .foregroundStyle(.blue)
                    Text("총 열량(kcal) : \(nutrition.nutrCont1)")
                    Text("탄수화물(g) : \(nutrition.nutrCont2)")
                    Text("단백질(g) : \(nutrition.nutrCont3)")
                    Text("지방(g) : \(nutrition.nutrCont4)")
                    Text("당류(g) : \(nutrition.nutrCont5)")
                }
                Chart {
                    ForEach(foodTemp, id: \.name) { nut in
                        SectorMark(
                            angle: .value("에?", Int(nut.count)),
                            innerRadius: .ratio(0.65),
                            angularInset: 2.0
                        )
                        .foregroundStyle(by: .value("Type", nut.name))
                        .cornerRadius(10.0)
                        .annotation(position: .overlay) {
                            Text("\(nut.count)")
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                    }
                }
                .frame(height: 230)
            }
        }
    }
}

//#Preview {
//    @StateObject var foodStore: FoodStore = FoodStore(food: foodData)
//    return SeasonedGrilledEelView(nutrition: $foodStore.food.nutrition[0])
//}
