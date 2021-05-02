//
//  IngredientMeasurement+CoreDataProperties.swift
//  Assigment 2
//
//  Created by Dana Casella on 2/5/21.
//
//

import Foundation
import CoreData


extension IngredientMeasurement {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IngredientMeasurement> {
        return NSFetchRequest<IngredientMeasurement>(entityName: "IngredientMeasurement")
    }

    @NSManaged public var name: String?
    @NSManaged public var quantity: String?
    @NSManaged public var meal: Meal?

}

extension IngredientMeasurement : Identifiable {

}
