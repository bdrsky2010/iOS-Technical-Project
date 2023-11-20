//
//  ContentView.swift
//  Papago
//
//  Created by Minjae Kim on 11/13/23.
//

import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
	// 파파고 api를 request하는 과정에서 사용할 프로퍼티들과 request 메서드를 담아줄 객체
	@StateObject var papagoStore = PapagoStore()
	
	// 파파고 api request하여 받아온 번역결과를 보여줄 저장 프로퍼티
	@State private var text: String = ""
	
	// source로 사용할 언어 선택하는 모달뷰를 보여주기 위한 저장 프로퍼티
	@State private var isShowSourceLanguage: Bool = false
	// target로 사용할 언어 선택하는 모달뷰를 보여주기 위한 저장 프로퍼티
	@State private var isShowTargetLanguage: Bool = false
	
	// 키보드 리턴키 타입과 text font size 세팅할 수 있는 모달뷰를 보여주기위한 저장 프로퍼티
	@State private var isShowSettingView: Bool = false
	
	@State private var doneOrReturnKeyboardType: Bool = false
	@State private var keyboardReturnType: UIReturnKeyType = .done
	
	@State private var selectFontIndex: Int = 2
	private var fontSizes: [Font] = FontRange.allCases.map { $0.font }
	
	@State private var isShowToast: Bool = false
	
	@State private var textViewHeight: CGFloat = 50
	let placeholder: String = "번역할 내용을 입력하세요."
	
	var body: some View {
		VStack {
			HStack(spacing: 18) {
				SideToolbarButton(systemName: "arrow.left", isShowSettingView: $isShowSettingView)
				
				Button {
					self.isShowSourceLanguage.toggle()
				} label: {
					LanguageSelectButton(language: papagoStore.languageArray[papagoStore.sourceIndex].language)
				}
				
				SwapLanguageButton(text: $text).environmentObject(papagoStore)
				
				Button {
					self.isShowTargetLanguage.toggle()
				} label: {
					LanguageSelectButton(language: papagoStore.languageArray[papagoStore.targetIndex].language)
				}
				
				SideToolbarButton(systemName: "line.3.horizontal",
								  isShowSettingView: $isShowSettingView)
				
			}
			.padding(10)
			.foregroundStyle(Color.init(hex: "#8EBBFF"))
			
			Divider()
				.background(Color.init(hex: "#8EBBFF"))
			ScrollView {
				VStack {
					HStack {
						if !papagoStore.text.isEmpty {
							ClipboardCopyButton(text: papagoStore.text,
												isShowToast: $isShowToast)
						}
						Spacer()
						Button {
							papagoStore.text = placeholder
							text = ""
						} label: {
							Image(systemName: "xmark")
								.foregroundStyle(Color.init(hex: "#8EBBFF"))
						}
					}
					.padding(.bottom, 5)
					CustomTextfield(isTranslation: $papagoStore.isTranslation,
									text: $papagoStore.text,
									height: $textViewHeight,
									returnKeyboardType: $keyboardReturnType,
									placeholder: placeholder,
									placeholderColor: UIColor.init(hex: "#8EBBFF"),
									fontSize: 25,
									fontWeight: .bold,
									textColor: .white,
									maxHeight: .infinity,
									bacground: UIColor.init(hex: "#24293E"))
					.frame(height: textViewHeight)
					.onSubmit {
						dump("submit")
					}
					.onChange(of: papagoStore.isTranslation) {
						dump(papagoStore.isTranslation)
						dump(papagoStore.text)
						self.text.removeAll()
						Task {
							/*
							 입력이 여러 줄로 들어왔을 경우 \n 뒤의 문자들은 쿼리로 들어가지도 않으며
							 번역도 이뤄지지 않음
							 배열하나를 선언 후 입력받은 문자열을 \n을 기준으로 나눠주고
							 나눠준 요소를 순회하며 번역하고 위에서 선언한 배열에 append해주는 방식으로
							 마지막에 배열을 joined 구문을 사용하여 요소 사이이 \n을 넣어주어
							 출력해줄 Text에도 그대로 줄을 다시 띄어주도록 구현
							 */
							var items: [String] = []
							for item in papagoStore.text.components(separatedBy: "\n") {
								let text = await papagoStore.requestTranslation(source: papagoStore.source,
																				target: papagoStore.target,
																			 text: item)
								items.append(text)
								dump(items)
							}
							self.text = items.joined(separator: "\n")
						}
					}
					.onChange(of: text) {
						papagoStore.isTranslation = false
					}
				}
				.padding()
				Divider()
					.background(Color.init(hex: "#8EBBFF"))
				HStack {
					VStack(alignment: .leading) {
						if !text.isEmpty {
							ClipboardCopyButton(text: self.text,
												isShowToast: $isShowToast)
						}
						Text(text)
							.foregroundStyle(Color.init(hex: "#8EBBFF"))
							.font(fontSizes[selectFontIndex])
					}
					Spacer()
				}
				.padding()
				.contentShape(Rectangle())
				.onTapGesture {
					hideKeyboard()
					if papagoStore.text != placeholder {
						papagoStore.isTranslation = true
					}
					dump(papagoStore.isTranslation)
				}
			}
		}
		.background(Color.init(hex: "#24293E"))
		.foregroundStyle(.white)
		.sheet(isPresented: self.$isShowSourceLanguage) {
			LanguageListView(isShow: $isShowSourceLanguage, method: "입력").environmentObject(papagoStore)
		}
		.sheet(isPresented: self.$isShowTargetLanguage) {
			LanguageListView(isShow: $isShowTargetLanguage, method: "번역").environmentObject(papagoStore)
		}
		.sheet(isPresented: $isShowSettingView) {
			SettingModalView(doneOrReturnKeyboardType: $doneOrReturnKeyboardType, selectFontIndex: $selectFontIndex)
				.presentationDetents([.medium])
				.onChange(of: doneOrReturnKeyboardType) {
					keyboardReturnType = doneOrReturnKeyboardType ? .default : .done
				}
		}
		.toast(message: "클립보드에 복사되었습니다.",
			   isShowing: $isShowToast,
			   config: Toast.Config(font: .body,
									textColor: .white,
									backgroundColor: Color.init(hex: "#8EBBFF")))
	}
}

struct SideToolbarButton: View {
	let systemName: String
	
	@Binding var isShowSettingView: Bool
	
	var body: some View {
		Button {
			if systemName == "line.3.horizontal" {
				isShowSettingView.toggle()
			}
		} label: {
			Image(systemName: systemName)
				.resizable()
				.frame(width: 20, height: 20)
		}
	}
}

#Preview {
	ContentView()
}
