//
//  Extension.swift
//  Papago
//
//  Created by Minjae Kim on 11/14/23.
//

import SwiftUI

extension Color {
  init(hex: String) {
	let scanner = Scanner(string: hex)
	_ = scanner.scanString("#")
	
	var rgb: UInt64 = 0
	scanner.scanHexInt64(&rgb)
	
	let r = Double((rgb >> 16) & 0xFF) / 255.0
	let g = Double((rgb >>  8) & 0xFF) / 255.0
	let b = Double((rgb >>  0) & 0xFF) / 255.0
	self.init(red: r, green: g, blue: b)
  }
}

extension UIColor {
	convenience init(hex: String, alpha: CGFloat = 1.0) {
		let scanner = Scanner(string: hex)
		_ = scanner.scanString("#")
		
		var rgb: UInt64 = 0
		scanner.scanHexInt64(&rgb)
		
		let r = Double((rgb >> 16) & 0xFF) / 255.0
		let g = Double((rgb >>  8) & 0xFF) / 255.0
		let b = Double((rgb >>  0) & 0xFF) / 255.0
		self.init(red: r, green: g, blue: b, alpha: alpha)
	}
}

extension View {
  func hideKeyboard() {
	UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
