//
//  RestaurantDetailView.swift
//  FoodNutrition
//
//  Created by Minjae Kim on 11/4/23.
//

import SwiftUI
import MapKit
import WebKit

struct RestaurantDetailView: View {
	
	let restaurant: Item
	
	var body: some View {
		Form {
			Section {
				RestaurantMapView(restaurantName: restaurant.title.removeTag, restaurantCoordinate: CLLocationCoordinate2D(latitude: restaurant.mapy.stringTolatitude, longitude: restaurant.mapx.stringTolongitude))
					.padding()
					.clipShape(.rect(cornerRadius: 20))
					.frame(height: 200)
			} header: {
				Text("위치")
			}
			
			Section {
				Text(restaurant.title.removeTag)
			} header: {
				Text("식당")
			}
			
			Section {
				Text(restaurant.telephone)
			} header: {
				Text("전화번호")
			}
			
			Section {
				NavigationLink(destination: RestaurantWebLinkView(webView: WebView(request: URLRequest(url: URL(string: restaurant.link) ?? URL(string: "https://www.google.com")!)))) {
					Text("여기를 누르시면 식당 홈페이지로 이동합니다.")
				}
			} header: {
				Text("홈페이지")
			}
			
			Section {
				Text(restaurant.address)
			} header: {
				Text("지번주소")
			}
			
			Section {
				Text(restaurant.roadAddress)
			} header: {
				Text("도로명주소")
			}
		}
	}
}

//#Preview {
//	RestaurantDetailView()
//}
