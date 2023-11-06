//
//  RestaurantWebLinkView.swift
//  FoodNutrition
//
//  Created by Minjae Kim on 11/4/23.
//

import SwiftUI

struct RestaurantWebLinkView: View {
	
	let webView: WebView
	
	var body: some View {
		VStack {
			webView
			HStack {
				Button(action: {
					webView.goBack()
				}, label: {
					Image(systemName: "arrowshape.left.fill")
						.font(.title)
						.foregroundColor(.black)
						.padding()
				})
				Spacer()
				Button(action: {
					webView.goFoward()
				}, label: {
					Image(systemName: "arrowshape.right.fill")
						.font(.title)
						.foregroundColor(.black)
						.padding()
				})
				Spacer()
				Button(action: {
					webView.refresh()
				}, label: {
					Image(systemName: "arrow.clockwise.circle.fill")
						.font(.title)
						.foregroundColor(.black)
						.padding()
				})
				Spacer()
				Button(action: {
					webView.goHome()
				}, label: {
					Image(systemName: "house.fill")
						.font(.title)
						.foregroundColor(.black)
						.padding()
				})
			}
			.padding([.horizontal], 20)
		}
	}
}

#Preview {
	RestaurantWebLinkView(webView: WebView(request: URLRequest(url: URL(string: "https://likelion.notion.site/2-S2-c8d7903718b445a58bee5849a7007cfd")!)))
}
