//
//  DumplingSoupView.swift
//  FoodNutrition
//
//  Created by Minjae Kim on 11/2/23.
//

import SwiftUI

struct DumplingSoupView: View {
    
    @Binding var nutrition: Nutrition
    
    var body: some View {
        Form {
            Section {
                Image(._6)
                    .resizable()
                    .clipShape(.rect(cornerRadius: 12.0))
                    .aspectRatio(contentMode: .fit)
                    .padding()
                
                HStack {
                    Image(systemName: "person")
                    Text("1인분")
                    Image(systemName: "timer")
                    Text("10분 이내")
                }
                
                VStack (alignment:.leading) {
                    Text("재료")
                        .font(.headline)
                        .fontWeight(.bold)
                    Divider()
                        .frame(width: 320, height: 2)
                        .background(Color.black)
                    HStack {
                        Text("떡")
                        Spacer()
                        Text("2줌")
                    }
                    Divider()
                    HStack {
                        Text("만두")
                        Spacer()
                        Text("5개")
                    }
                    Divider()
                    HStack {
                        Text("당근")
                        Spacer()
                        Text("1/2개")
                    }
                    Divider()
                    HStack {
                        Text("양파")
                        Spacer()
                        Text("1/6개")
                    }
                    Divider()
                    HStack {
                        Text("애호박")
                        Spacer()
                        Text("1/4개")
                    }
                    Divider()
                    HStack {
                        Text("달걀")
                        Spacer()
                        Text("1개")
                    }
                    Divider()
                    HStack {
                        Text("대파")
                        Spacer()
                        Text("1대")
                    }
                }
                .padding()
                
                VStack (alignment:.leading) {
                    Text("육수")
                        .font(.headline)
                        .fontWeight(.bold)
                    Divider()
                        .frame(width: 320, height: 2)
                        .background(Color.black)
                    HStack {
                        Text("멸치")
                        Spacer()
                        Text("10마리")
                    }
                    Divider()
                    HStack {
                        Text("다시마")
                        Spacer()
                        Text("2장")
                    }
                }
                .padding()
                
                VStack (alignment:.leading) {
                    Text("국 간")
                        .font(.headline)
                        .fontWeight(.bold)
                    Divider()
                        .frame(width: 320, height: 2)
                        .background(Color.black)
                    HStack {
                        Text("국간장")
                        Spacer()
                        Text("2T")
                    }
                    Divider()
                    HStack {
                        Text("소금")
                        Spacer()
                        Text("1t")
                    }
                    Divider()
                    HStack {
                        Text("후추")
                        Spacer()
                        Text("1/2t")
                    }
                    Divider()
                    HStack {
                        Text("참기름")
                        Spacer()
                        Text("1/2T")
                    }
                }
                .padding()
                
                VStack (alignment:.leading) {
                    Text("조리순서")
                        .font(.headline)
                        .fontWeight(.bold)
                    Divider()
                        .frame(width: 320, height: 2)
                        .background(Color.black)
                    HStack(alignment: .firstTextBaseline) {
                        Text("1.")
                            .font(.headline)
                        Text("당근, 양파, 애호박은 모두 채썰어주고 대파는 송송 썰어주세요.")
                    }
                    .padding()
                    HStack(alignment: .firstTextBaseline) {
                        Text("2.")
                            .font(.headline)
                        Text("떡은 물에 담가 불려주세요.")
                    }
                    .padding()
                    HStack(alignment: .firstTextBaseline) {
                        Text("3.")
                            .font(.headline)
                        Text("달걀 1개는 그릇에 대강 풀어주세요.")
                    }
                    .padding()
                    HStack(alignment: .firstTextBaseline) {
                        Text("4.")
                            .font(.headline)
                        Text("냄비에 준비한 멸치, 다시마를 넣고 물이 끓으면 다시마는 진액이 나오기 때문에 건져준 후 15분간 끓여주고 멸치를 건져주세요.")
                    }
                    .padding()
                    HStack(alignment: .firstTextBaseline) {
                        Text("5.")
                            .font(.headline)
                        Text("육수에 당근과 애호박을 넣어 주세요. 양파는 아삭한 식감을 위해 나중에 넣어줄거에요. 아삭한 식감을 싫어하신다면 이때 넣어주시면 됩니다.")
                    }
                    .padding()
                    HStack(alignment: .firstTextBaseline) {
                        Text("6.")
                            .font(.headline)
                        Text("당근이 익어가면 불린 떡을 넣어주세요.")
                    }
                    .padding()
                    HStack(alignment: .firstTextBaseline) {
                        Text("7.")
                            .font(.headline)
                        Text("간은 국간장 2T, 소금 1t를 넣어주세요")
                    }
                    .padding()
                    HStack(alignment: .firstTextBaseline) {
                        Text("8.")
                            .font(.headline)
                        Text("양파의 아삭한 식감을 좋아해서 간을 한 후 양파를 넣어줬어요.")
                    }
                    .padding()
                    HStack(alignment: .firstTextBaseline) {
                        Text("9.")
                            .font(.headline)
                        Text("후추는 1/2t정도 톡톡 뿌려주세요. 부족한 간은 취향껏 맞춰주세요. 국간장은 너무 많이 넣으면 색이 까매지니 향만 내주고 나머지는 소금으로 간해주세요.")
                    }
                    .padding()
                    HStack(alignment: .firstTextBaseline) {
                        Text("10.")
                            .font(.headline)
                        Text("간을 다 맞추면 만두를 넣어주세요.")
                    }
                    .padding()
                    HStack(alignment: .firstTextBaseline) {
                        Text("11.")
                            .font(.headline)
                        Text("보글보글 끓여주다가 계란을 원으로 둘러주세요.")
                    }
                    .padding()
                    HStack(alignment: .firstTextBaseline) {
                        Text("12.")
                            .font(.headline)
                        Text("떡만둣국의 포인트, 참기를 1/2T를 넣어주세요.")
                    }
                    .padding()
                    HStack(alignment: .firstTextBaseline) {
                        Text("13.")
                            .font(.headline)
                        Text("마무리로 대파를 넣어주면 완성이에요.")
                    }
                    .padding()
                }
            } header: {
                HStack {
                    Text("조리법")
                }
            }
        }
        .navigationTitle("떡만둣국 레시피")
    }
}

//#Preview {
//    DumplingSoupView(nutrition: foodData.nutrition[5])
//}
