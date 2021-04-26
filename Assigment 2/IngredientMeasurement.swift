//
//  IngredientMeasurement.swift
//  Assigment 2: Portfolio Exercises
//
//  Created by Dana Casella on 24/4/21.
//

import Foundation

class IngredientMeasurement: NSObject {
    var name: String
    var quantity: String
    
    init(name: String, quantity: String) {
        self.name = name
        self.quantity = quantity
    }
}
