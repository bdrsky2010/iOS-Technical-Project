//
//  LanguageSelectButton.swift
//  Papago
//
//  Created by Minjae Kim on 11/15/23.
//

import SwiftUI

struct LanguageSelectButton: View {
	let language: String
    var body: some View {
		HStack {
			Text(language)
				.fontWeight(.bold)
			Image(systemName: "chevron.down")
				.resizable()
				.frame(width: 8, height: 5)
		}
		.frame(width: 115)
    }
}

#Preview {
    LanguageSelectButton(language: "아몰랑")
}
