//
//  Toast.swift
//  Papago
//
//  Created by Minjae Kim on 11/16/23.
//

import SwiftUI

struct Toast: ViewModifier {
	
	let message: String
	@Binding var isShowing: Bool
	let config: Config
	
	func body(content: Content) -> some View {
		ZStack {
			content
			toastView
		}
	}
	
	private var toastView: some View {
		VStack {
			Spacer()
			if isShowing {
				HStack {
					Spacer()
					Text(message)
						.foregroundColor(.white)
						.font(config.font)
						.padding(8)
					Spacer()
				}
				.background(config.backgroundColor)
				.clipShape(.rect(cornerRadius: 15))
				.onTapGesture {
					isShowing = false
				}
				.onAppear {
					DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
						isShowing = false
					}
				}
			}
		}
		.padding(.horizontal, 50)
		.padding(.bottom, 18)
		.animation(.linear(duration: 0.3), value: isShowing)
		.transition(.opacity)
	}
	
	struct Config {
		let font: Font
		let textColor: Color
		let backgroundColor: Color
	}
}

extension View {
	func toast(message: String, isShowing: Binding<Bool>, config: Toast.Config) -> some View {
		self.modifier(Toast(message: message, isShowing: isShowing, config: config))
	}
}
