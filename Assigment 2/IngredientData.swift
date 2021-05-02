//
//  IngredientData.swift
//  Assigment 2
//
//  Created by Dana Casella on 30/4/21.
//

import UIKit

class IngredientData: NSObject, Decodable {
    var name: String
    var ingredientDescription: String?
    
    private enum IngredientKeys: String, CodingKey {
        case name = "strIngredient"
        case ingredientDescription = "strDescription"
    }
    
    required init(from decoder: Decoder) throws {
        
        // get root container
        let ingredientContainer = try decoder.container(keyedBy: IngredientKeys.self)
        
        // collect ingredient data
        name = try ingredientContainer.decode(String.self, forKey: .name)
        ingredientDescription = try? ingredientContainer.decode(String.self, forKey: .ingredientDescription)
    }
}
