//
//  MyMultilneTextView.swift
//  Papago
//
//  Created by Minjae Kim on 11/18/23.
//

import SwiftUI

struct MyMultilneTextView: View {
    var body: some View {
		CustomTextfield(text: .constant("안녕하세요"),
						placeholder: Text("번역할 내용을 입력하세요").foregroundStyle(Color.init(hex: "#8EBBFF")),
						font: .title1,
						textColor: Color.init(hex: ""))
    }
}

struct CustomTextfield: UIViewRepresentable {
	@Binding var text: String
	let placeholder: Text
	let font: UIFont.TextStyle
	let textColor: Color
	
	// 처음에 View 렌더링 해주는 메서드
	func makeUIView(context: Context) -> some UITextView {
		let textView = UITextView()
		textView.font = .preferredFont(forTextStyle: font)
		textView.autocapitalizationType = .sentences
		textView.isSelectable = true
		
		return textView
	}
	
	// View 업데이트되면 다시 View 렌더링해주는 메서드
	func updateUIView(_ uiView: UITextView, context: Context) {
		uiView.text = text
		uiView.font = .preferredFont(forTextStyle: font)
	}
	
	func makeCoordinator() -> Coordinator {
		Coordinator($text)
	}
	
	class Coordinator: NSObject, UITextViewDelegate {
		var text: Binding<String>
		
		init(_ text: Binding<String>) {
			self.text = text
		}
		
		func textViewDidChange(_ textView: UITextView) {
			self.text.wrappedValue = textView.text
		}
	}
}

#Preview {
    MyMultilneTextView()
}
