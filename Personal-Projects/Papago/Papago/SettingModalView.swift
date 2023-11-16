//
//  SettingView.swift
//  Papago
//
//  Created by Minjae Kim on 11/15/23.
//

import SwiftUI

enum FontRange: String, CaseIterable, Hashable {
	case minimum = "최소"
	case small = "작게"
	case regular = "보통"
	case large = "크게"
	
	var font: Font {
		switch self {
		case .minimum:
			return .system(size: 17, weight: .bold)
		case .small:
			return .system(size: 24, weight: .bold)
		case .regular:
			return .system(size: 36, weight: .bold)
		case .large:
			return .system(size: 50, weight: .bold)
		}
	}
}

struct SettingModalView: View {
	// 키보드 return 버튼을 .done 으로 사용할 것인지, .return 으로 사용할 것인지 알려주기 위한 저장 프로퍼티
	// false면 .done, true면 .return
	@Binding var doneOrReturnKeyboardType: Bool
	
	let fonts: [FontRange] = FontRange.allCases
	//
	@Binding var selectFontIndex: Int
	
    var body: some View {
		VStack {
			VStack {
				HStack {
					VStack(alignment: .leading) {
						Text("텍스트 줄바꿈")
							.fontWeight(.bold)
							.font(.title3)
							.foregroundStyle(.white)
						Text("키보드 내 완료 키 대신 줄바꿈 키로 제공합니다.")
							.font(.callout)
							.foregroundStyle(Color.init(hex: "#8EBBFF"))
					}
					
					Spacer()
					
					Toggle("", isOn: $doneOrReturnKeyboardType)
						.tint(Color.init(hex: "#8EBBFF"))
						.frame(width: 50)
						.padding(.top)
				}
				
				HStack() {
					Image("done")
						.resizable()
						.frame(width: 150, height: 200)
						.onTapGesture {
							if doneOrReturnKeyboardType {
								doneOrReturnKeyboardType.toggle()
							}
						}
						.overlay {
							if !doneOrReturnKeyboardType {
								keyboardImageButton(hexcode: "#8EBBFF")
							}
							
							if doneOrReturnKeyboardType {
								keyboardImageButton(hexcode: "#24293E")
							}
						}
					
					Spacer()
					
					Image("return")
						.resizable()
						.frame(width: 150, height: 200)
						.onTapGesture {
							if !doneOrReturnKeyboardType {
								doneOrReturnKeyboardType.toggle()
							}
						}
						.overlay {
							if doneOrReturnKeyboardType {
								keyboardImageButton(hexcode: "#8EBBFF")
							}
							
							if !doneOrReturnKeyboardType {
								keyboardImageButton(hexcode: "#24293E")
							}
						}
				}
				.padding()
			}
			Divider()
				.background(Color.init(hex: "#8EBBFF"))
			
			VStack {
				HStack {
					VStack(alignment: .leading) {
						Text("글자 크기")
							.fontWeight(.bold)
							.font(.title3)
							.foregroundStyle(.white)
						Text("글자를 원하는 크기로 설정해보세요.")
							.font(.callout)
							.foregroundStyle(Color.init(hex: "#8EBBFF"))
					}
					Spacer()
				}
				
				Picker("", selection: $selectFontIndex) {
					ForEach(0..<4) { i in
						Text(fonts[i].rawValue)
							.tag(i)
					}
				}
				.pickerStyle(.segmented)
				.background(Color.init(hex: "#8EBBFF"))
				.clipShape(.rect(cornerRadius: 5))
			}
			
			Spacer()
		}
		.padding()
		.background(Color.init(hex: "#2F3651"))
    }
}

struct keyboardImageButton: View {
	let hexcode: String
	
	var body: some View {
		RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
			.stroke(lineWidth: 2)
			.foregroundStyle(Color.init(hex: hexcode))
	}
}

//#Preview {
//	SettingModalView()
//}
