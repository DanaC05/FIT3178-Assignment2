//
//  DatabaseProtocol.swift
//  Assigment 2
//
//  Created by Dana Casella on 28/4/21.
//

import Foundation

protocol DatabaseListener : AnyObject {
    func onLibraryChange(storedMeals: [Meal])
}

protocol DatabaseProtocol : AnyObject {
    var myMealLibrary: MealLibrary {get}
    
    func cleanUp()
    func tidyUp()
    
    func addListener(listener: DatabaseListener)
    func removeListener(listener: DatabaseListener)
    
    func addMealLibrary(mealLibraryName: String) -> MealLibrary
    func deleteMealLibrary(mealLibrary: MealLibrary)
    func addMealToMealLibrary(meal: Meal, mealLibrary: MealLibrary) -> Bool
    func removeMealFromMealLibrary(meal: Meal, mealLibrary: MealLibrary)
    
    func addMeal(mealData: MealData) -> Meal?
    func passMeal(meal: Meal?) -> Meal
    func deleteMeal(meal: Meal)
    func addIngredientToMeal(ingredient: IngredientMeasurement, meal: Meal) -> Bool
    func removeIngredientFromMeal(ingredient: IngredientMeasurement, meal: Meal)
    
    func addIngredientMeasurement(name: String, quantity: String) -> IngredientMeasurement
    func deleteIngredientMeasurement(ingredientMeasurement: IngredientMeasurement)
    
    func addIngredientData(ingredientData: IngredientData) -> Ingredient
}
