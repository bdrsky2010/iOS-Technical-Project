//
//  MyMultilneTextView.swift
//  Papago
//
//  Created by Minjae Kim on 11/18/23.
//

import SwiftUI

struct MyMultilneTextView: View {
	@State private var text: String = ""
	var body: some View {
		CustomTextfield(isTranslation: .constant(false),
						text: $text,
						height: .constant(200),
						returnKeyboardType: .constant(.done),
						placeholder: "번역할 내용을 입력하세요",
						placeholderColor: .lightGray,
						fontSize: 30,
						fontWeight: .bold,
						textColor: .blue,
						maxHeight: .infinity)
	}
}

struct CustomTextfield: UIViewRepresentable {
	@Binding var isTranslation: Bool
	@Binding var text: String
	@Binding var height: CGFloat
	@Binding var returnKeyboardType: UIReturnKeyType
	var placeholder: String?
	var placeholderColor: UIColor?
	var fontSize: CGFloat?
	var fontWeight: UIFont.Weight?
	var textColor: UIColor?
	var maxHeight: CGFloat
	var bacground: UIColor?
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
	
	func makeUIView(context: Context) -> UITextView {
		let textView = UITextView()
		
		if let fontSize = fontSize {
			textView.font = .systemFont(ofSize: fontSize)
		}
		if let fontSize = fontSize, let fontWeight = fontWeight {
			textView.font = .systemFont(ofSize: fontSize, weight: fontWeight)
		}
		if let placeholder = placeholder {
			dump(placeholder)
			textView.text = placeholder
		}
		if let placeholderColor = placeholderColor {
			textView.textColor = placeholderColor
		} else {
			textView.textColor = .lightGray
		}
		if let bacground = bacground {
			textView.backgroundColor = bacground
		}
		textView.delegate = context.coordinator
		return textView
	}
	
	func updateUIView(_ uiView: UITextView, context: Context) {
		dump("updateUIView()")
		if !text.isEmpty {
			uiView.text = text
		}
		if uiView.text == placeholder {
			uiView.textColor = placeholderColor
		}
		uiView.returnKeyType = returnKeyboardType
		updateHeight(uiView)
	}
	
	private func updateHeight(_ uiView: UITextView) {
		dump("updateHeight()")
		DispatchQueue.main.async {
			if uiView.contentSize.height <= maxHeight {
				height = uiView.contentSize.height
			}
		}
	}
}

class Coordinator: NSObject, UITextViewDelegate {
	
	var parent: CustomTextfield
	
	init(_ uiTextView: CustomTextfield) {
		self.parent = uiTextView
	}
	
	func textViewDidChange(_ textView: UITextView) {
		dump("textViewDidChange()")
		self.parent.text = textView.text
		
		if textView.text.isEmpty {
			textView.text = parent.placeholder
			textView.textColor = parent.placeholderColor
		} else {
			textView.textColor = parent.textColor
		}
		
		if textView.text == self.parent.placeholder {
			textView.text = ""
		}
		
		if textView.text.count > 200 {
			textView.text.removeLast()
		}
	}
	
	func textViewDidBeginEditing(_ textView: UITextView) {
		dump("textViewDidBeginEditing()")
		if textView.text == self.parent.placeholder {
			textView.text = ""
		}
	}
	
	func textViewDidEndEditing(_ textView: UITextView) {
		dump("textViewDidEndEditing()")
		if textView.text.isEmpty {
			textView.text = parent.placeholder
			textView.textColor = parent.placeholderColor
			dump(textView.text)
		}
	}
	
	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		if textView.returnKeyType == .done && text == "\n" {
			parent.text = textView.text
			parent.isTranslation = true
			textView.resignFirstResponder()
		}
		if textView.returnKeyType == .default {
			dump("return")
		}
		return true
	}
}

#Preview {
	MyMultilneTextView()
}
