//
//  Meal.swift
//  Assigment 2: Portfolio Exercises
//
//  Created by Dana Casella on 24/4/21.
//

import Foundation

class Meal: NSObject {
    var name: String
    var mealCategory: String?
    var cuisine: String?
    var instructions: String
    var mealThumbnailLink: String?
    var ingredients = [IngredientMeasurement]()
    
    init(name: String, instructions: String, mealThumbnailLink: String) {
        self.name = name
        self.instructions = instructions
        self.mealThumbnailLink = mealThumbnailLink
    }
}
