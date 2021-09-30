//
//  Meals.swift
//  Fetch Rewards Code Challenge Alex C
//
//  Created by Alex Constancio on 9/28/21.
//

struct Meal: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

struct MealEntry: Codable {
    let meals: [Meal]
}
