//
//  WebViewController.swift
//  FoodNutrition
//
//  Created by Minjae Kim on 11/4/23.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
	let request: URLRequest
	private var webView: WKWebView?
	
	init(request: URLRequest) {
		self.webView = WKWebView()
		self.request = request
	}
	
	func makeUIView(context: Context) -> WKWebView {
		return webView!
	}
	
	func updateUIView(_ uiView: WKWebView, context: Context) {
		uiView.load(request)
	}
	
	func goBack() { webView?.goBack() }
	
	func goFoward() { webView?.goForward() }
	
	func refresh() { webView?.reload() }
	
	func goHome() { webView?.load(request) }
}
