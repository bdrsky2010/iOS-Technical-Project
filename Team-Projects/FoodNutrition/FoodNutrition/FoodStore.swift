//
//  FoodStore.swift
//  FoodNutrition
//
//  Created by Minjae Kim on 11/2/23.
//

import SwiftUI

class FoodStore: ObservableObject {
	@Published var food: Food
	
	init(food: Food) {
		self.food = food
	}
}
