//
//  Meal+CoreDataProperties.swift
//  Assigment 2
//
//  Created by Dana Casella on 28/4/21.
//
//

import Foundation
import CoreData


extension Meal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meal> {
        return NSFetchRequest<Meal>(entityName: "Meal")
    }

    @NSManaged public var cuisine: String?
    @NSManaged public var instructions: String?
    @NSManaged public var mealCategory: String?
    @NSManaged public var mealThumbnailLink: String?
    @NSManaged public var name: String?
    @NSManaged public var ingredients: NSSet?

}

// MARK: Generated accessors for ingredients
extension Meal {

    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: IngredientMeasurement)

    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: IngredientMeasurement)

    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSSet)

    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSSet)

}

extension Meal : Identifiable {

}
