//
//  MealDataArray.swift
//  Assigment 2
//
//  Created by Dana Casella on 30/4/21.
//

import UIKit

class MealDataArray: NSObject, Decodable {
    
    var meals: [MealData]?
    
    private enum CodingKeys: String, CodingKey {
        case meals
    }

}
