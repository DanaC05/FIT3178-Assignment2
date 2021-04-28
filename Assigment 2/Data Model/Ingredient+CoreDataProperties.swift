//
//  Ingredient+CoreDataProperties.swift
//  Assigment 2
//
//  Created by Dana Casella on 28/4/21.
//
//

import Foundation
import CoreData


extension Ingredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredient> {
        return NSFetchRequest<Ingredient>(entityName: "Ingredient")
    }

    @NSManaged public var ingredientDescription: String?
    @NSManaged public var name: String?

}

extension Ingredient : Identifiable {

}
