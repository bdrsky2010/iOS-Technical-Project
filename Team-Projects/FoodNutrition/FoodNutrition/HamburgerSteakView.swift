//
//  HamburgerSteakView.swift
//  FoodNutrition
//
//  Created by Minjae Kim on 11/2/23.
//

import SwiftUI

struct HamburgerSteakView: View {
    
    @Binding var nutrition: Nutrition
    @State private var isAnimated: Bool = false
    @State private var isHovering = false
    
    var body: some View {
        
        Section(header: customLabel) {
            List{
                Link("구슬함박 파미에파크점", destination: URL(string: "https://map.naver.com/p/search/%ED%96%84%EB%B2%84%EA%B1%B0%20%EC%8A%A4%ED%85%8C%EC%9D%B4%ED%81%AC%20%EB%A7%9B%EC%A7%91/place/31375404?placePath=?entry=pll&from=nx&fromNxList=true&c=15.00,0,0,0,dh")!).foregroundColor(.black)
                
                Link("오른손푸드카페", destination: URL(string: "https://map.naver.com/p/search/%ED%96%84%EB%B2%84%EA%B1%B0%20%EC%8A%A4%ED%85%8C%EC%9D%B4%ED%81%AC%20%EB%A7%9B%EC%A7%91/place/31601162?placePath=?entry=pll&from=nx&fromNxList=true&c=15.00,0,0,0,dh")!).foregroundColor(.black)
                Link("시드니스테이크", destination: URL(string: "https://map.naver.com/p/search/%ED%96%84%EB%B2%84%EA%B1%B0%20%EC%8A%A4%ED%85%8C%EC%9D%B4%ED%81%AC%20%EB%A7%9B%EC%A7%91/place/1324045429?placePath=?entry=pll&from=nx&fromNxList=true&c=15.00,0,0,0,dh")!).foregroundColor(.black)
            }
        }
        
    }
    
    var customLabel: some View {
        Label("맛집정보", systemImage: "fork.knife.circle.fill")
            .symbolEffect(.bounce.up, value: isAnimated)
            .aspectRatio(contentMode: .fit)
            .foregroundStyle(.black, .yellow)
            .symbolRenderingMode(.palette)
            .font(.system(size: 40, weight: .semibold))
            .onAppear{
                isAnimated.toggle()
            }
    }
    
    
}


//#Preview {
//	HamburgerSteakView()
//}
