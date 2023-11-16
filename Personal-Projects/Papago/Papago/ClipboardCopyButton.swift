//
//  ClipboardCopyButton.swift
//  Papago
//
//  Created by Minjae Kim on 11/17/23.
//

import SwiftUI

struct ClipboardCopyButton: View {
	
	let text: String
	
	@State private var pasteboard = UIPasteboard.general
	@Binding var isShowToast: Bool
	
	var body: some View {
		Button {
			pasteboard.string = self.text
			self.isShowToast.toggle()
		} label: {
			ZStack {
				Circle()
					.frame(width: 30, height: 30)
					.foregroundStyle(Color.init(hex: "#8EBBFF"))
				Image(systemName: "rectangle.portrait.on.rectangle.portrait")
					.resizable()
					.frame(width: 15, height: 20)
					.rotationEffect(.degrees(180))
			}
		}
	}
}
