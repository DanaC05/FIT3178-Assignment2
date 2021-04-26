//
//  Meal.swift
//  Assigment 2: Portfolio Exercises
//
//  Created by Dana Casella on 24/4/21.
//

import Foundation

class Meal {
    var name: String
    var mealCategory: String?
    var cuisine: String?
    var instructions: String
    var mealThumbnailLink: String?
    var ingredients = [IngredientMeasurement]()
    
    init() {
        // nothing yet
    }
}
