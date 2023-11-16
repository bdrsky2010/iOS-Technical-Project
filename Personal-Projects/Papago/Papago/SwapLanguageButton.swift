//
//  SwapLanguageButtonView.swift
//  Papago
//
//  Created by Minjae Kim on 11/14/23.
//

import SwiftUI

struct SwapLanguageButton: View {
	
	@EnvironmentObject var papagoStore: PapagoStore // 환경 객체 변수를 통해 papagoStore에 대한 프로퍼티와 메서드를 바인딩
	
	@Binding var text: String
	
	@State private var rotate: Double = 0 // 버튼 회전 애니메이션을 주기 위한 degree 저장 프로퍼티
	
	var body: some View {
		
		// 언어 스왑 버튼 정의
		Button {
			swapLanguage()
		} label: {
			Image(systemName: "arrow.right.arrow.left")
				.foregroundStyle(Color.init(hex: "#8EBBFF"))
				.overlay {
					RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
						.stroke()
						.frame(width: 40, height: 30)
						.foregroundStyle(Color.init(hex: "#8EBBFF"))
				}
				.rotationEffect(Angle(degrees: rotate)) // 버튼 회전 애니메이션
		}
	}
	private func swapLanguage() {
//		let sourceIndex: Int = papagoStore.languageArray.firstIndex(where: { $0.isSource }) ?? 0 // source에 해당하는 언어의 Index 검색
//		let targetIndex: Int = papagoStore.languageArray.firstIndex(where: { $0.isTarget }) ?? 0 // target에 해당하는 언어의 Index 검색
		
		// source에 해당하는 언어를 target으로 스왑
		papagoStore.languageArray[papagoStore.sourceIndex].isSource.toggle()
		papagoStore.languageArray[papagoStore.sourceIndex].isTarget.toggle()
		papagoStore.source = papagoStore.languageArray[papagoStore.targetIndex].languageCode.rawValue
		
		// target에 해당하는 언어를 source으로 스왑
		papagoStore.languageArray[papagoStore.targetIndex].isSource.toggle()
		papagoStore.languageArray[papagoStore.targetIndex].isTarget.toggle()
		papagoStore.target = papagoStore.languageArray[papagoStore.sourceIndex].languageCode.rawValue
		
		// 배열에서 source와 target에 접근하기 위한 index를 서로 swap
		(papagoStore.sourceIndex, papagoStore.targetIndex) = (papagoStore.targetIndex, papagoStore.sourceIndex)
		
		// 검색할 text와 번역받을 text를 서로 swap
		(papagoStore.text, text) = (text, papagoStore.text)
		
		// source와 target에 해당하는 언어의 정보 Log 출력
		dump(papagoStore.source)
		dump(papagoStore.sourceIndex)
		dump(papagoStore.target)
		dump(papagoStore.targetIndex)
		dump(papagoStore.text)
		
		rotate = rotate == 0 ? 180 : 0 // 버튼 회전 애니메이션을 주기 위한 degree 재정의
	}
}
