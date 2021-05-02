//
//  MealLibrary+CoreDataProperties.swift
//  Assigment 2
//
//  Created by Dana Casella on 2/5/21.
//
//

import Foundation
import CoreData


extension MealLibrary {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MealLibrary> {
        return NSFetchRequest<MealLibrary>(entityName: "MealLibrary")
    }

    @NSManaged public var name: String?
    @NSManaged public var savedMeals: NSSet?

}

// MARK: Generated accessors for savedMeals
extension MealLibrary {

    @objc(addSavedMealsObject:)
    @NSManaged public func addToSavedMeals(_ value: Meal)

    @objc(removeSavedMealsObject:)
    @NSManaged public func removeFromSavedMeals(_ value: Meal)

    @objc(addSavedMeals:)
    @NSManaged public func addToSavedMeals(_ values: NSSet)

    @objc(removeSavedMeals:)
    @NSManaged public func removeFromSavedMeals(_ values: NSSet)

}

extension MealLibrary : Identifiable {

}
