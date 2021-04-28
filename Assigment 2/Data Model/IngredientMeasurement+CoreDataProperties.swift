//
//  IngredientMeasurement+CoreDataProperties.swift
//  Assigment 2
//
//  Created by Dana Casella on 28/4/21.
//
//

import Foundation
import CoreData


extension IngredientMeasurement {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IngredientMeasurement> {
        return NSFetchRequest<IngredientMeasurement>(entityName: "IngredientMeasurement")
    }

    @NSManaged public var quantity: String?
    @NSManaged public var name: String?

}

extension IngredientMeasurement : Identifiable {

}
