//
//  ContentView.swift
//  Papago
//
//  Created by Minjae Kim on 11/13/23.
//

import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
	
	@StateObject var papagoStore = PapagoStore()
	
	@State private var text: String = ""
	
	@State private var isShowSourceLanguage: Bool = false
	@State private var isShowTargetLanguage: Bool = false
	
	@State private var isShowSettingView: Bool = false
	
	@State private var selectFontIndex: Int = 2
	
	@State private var doneOrReturnKeyboardType: Bool = false
	
	private var fontSizes: [Font] = FontRange.allCases.map { $0.font }
	
	@State private var isShowToast: Bool = false
	
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
							papagoStore.text = ""
						} label: {
							Image(systemName: "xmark")
								.foregroundStyle(Color.init(hex: "#8EBBFF"))
						}
					}
					.padding(.bottom, 5)
					TextField(text: $papagoStore.text,
							  prompt: Text("번역할 내용을 입력하세요").foregroundStyle(Color.init(hex: "#8EBBFF")),
							  axis: .vertical,
							  label: { })
					.submitLabel(doneOrReturnKeyboardType ? .return : .done)
					.onSubmit {
						print("submit")
					}
					.onChange(of: papagoStore.text) {
						Task {
//							self.text = await papagoStore.requestTranslation(source: papagoStore.source, 
//																			 target: papagoStore.target,
//																			 text: papagoStore.text)
						}
					}
					.font(.system(size: 25, weight: .bold))
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
