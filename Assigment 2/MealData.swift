//
//  MealData.swift
//  Assigment 2
//
//  Created by Dana Casella on 28/4/21.
//

import UIKit

class MealData: NSObject, Decodable {
    
    var name: String
    var mealCategory: String?
    var cuisine: String?
    var instructions: String?
    var mealThumbnailLink: String?
    var mealIngredients: [(name: String?, quantity: String?)] = []
    var strIngredient1: String?
    var strIngredient2: String?
    var strIngredient3: String?
    var strIngredient4: String?
    var strIngredient5: String?
    var strIngredient6: String?
    var strIngredient7: String?
    var strIngredient8: String?
    var strIngredient9: String?
    var strIngredient10: String?
    var strIngredient11: String?
    var strIngredient12: String?
    var strIngredient13: String?
    var strIngredient14: String?
    var strIngredient15: String?
    var strIngredient16: String?
    var strIngredient17: String?
    var strIngredient18: String?
    var strIngredient19: String?
    var strIngredient20: String?
    var strMeasure1: String?
    var strMeasure2: String?
    var strMeasure3: String?
    var strMeasure4: String?
    var strMeasure5: String?
    var strMeasure6: String?
    var strMeasure7: String?
    var strMeasure8: String?
    var strMeasure9: String?
    var strMeasure10: String?
    var strMeasure11: String?
    var strMeasure12: String?
    var strMeasure13: String?
    var strMeasure14: String?
    var strMeasure15: String?
    var strMeasure16: String?
    var strMeasure17: String?
    var strMeasure18: String?
    var strMeasure19: String?
    var strMeasure20: String?
       
    private enum MealKeys: String, CodingKey {
        case name = "strMeal"
        case mealCategory = "strCategory"
        case cuisine = "strArea"
        case instructions = "strInstructions"
        case mealThumbnailLink = "strMealThumb"
        case strIngredient1
        case strIngredient2
        case strIngredient3
        case strIngredient4
        case strIngredient5
        case strIngredient6
        case strIngredient7
        case strIngredient8
        case strIngredient9
        case strIngredient10
        case strIngredient11
        case strIngredient12
        case strIngredient13
        case strIngredient14
        case strIngredient15
        case strIngredient16
        case strIngredient17
        case strIngredient18
        case strIngredient19
        case strIngredient20
        case strMeasure1
        case strMeasure2
        case strMeasure3
        case strMeasure4
        case strMeasure5
        case strMeasure6
        case strMeasure7
        case strMeasure8
        case strMeasure9
        case strMeasure10
        case strMeasure11
        case strMeasure12
        case strMeasure13
        case strMeasure14
        case strMeasure15
        case strMeasure16
        case strMeasure17
        case strMeasure18
        case strMeasure19
        case strMeasure20
    }
    
    // decoder class instance - capable of throwing an error
    required init(from decoder: Decoder) throws {
        
        // get root conatainer (also meal container)
        let mealContainer = try decoder.container(keyedBy: MealKeys.self)
        
        // collect meal info
        name = try mealContainer.decode(String.self, forKey: .name)
        mealCategory = try? mealContainer.decode(String.self, forKey: .mealCategory)
        cuisine = try? mealContainer.decode(String.self, forKey: .cuisine)
        instructions = try? mealContainer.decode(String.self, forKey: .instructions)
        mealThumbnailLink = try? mealContainer.decode(String.self, forKey: .mealThumbnailLink)
        
        // collect ingredient information and add to mealIngredient array
        strIngredient1 = try? mealContainer.decode(String.self, forKey: .strIngredient1)
        strMeasure1 = try? mealContainer.decode(String.self, forKey: .strMeasure1)
        mealIngredients.append((name: strIngredient1, quantity: strMeasure1))
        
        strIngredient2 = try? mealContainer.decode(String.self, forKey: .strIngredient2)
        strMeasure2 = try? mealContainer.decode(String.self, forKey: .strMeasure2)
        mealIngredients.append((name: strIngredient2, quantity: strMeasure2))
        
        strIngredient3 = try? mealContainer.decode(String.self, forKey: .strIngredient3)
        strMeasure3 = try? mealContainer.decode(String.self, forKey: .strMeasure3)
        mealIngredients.append((name: strIngredient3, quantity: strMeasure3))
        
        strIngredient4 = try? mealContainer.decode(String.self, forKey: .strIngredient4)
        strMeasure4 = try? mealContainer.decode(String.self, forKey: .strMeasure4)
        mealIngredients.append((name: strIngredient4, quantity: strMeasure4))
        
        strIngredient5 = try? mealContainer.decode(String.self, forKey: .strIngredient5)
        strMeasure5 = try? mealContainer.decode(String.self, forKey: .strMeasure5)
        mealIngredients.append((name: strIngredient5, quantity: strMeasure5))
        
        strIngredient6 = try? mealContainer.decode(String.self, forKey: .strIngredient6)
        strMeasure6 = try? mealContainer.decode(String.self, forKey: .strMeasure6)
        mealIngredients.append((name: strIngredient6, quantity: strMeasure6))
        
        strIngredient7 = try? mealContainer.decode(String.self, forKey: .strIngredient7)
        strMeasure7 = try? mealContainer.decode(String.self, forKey: .strMeasure7)
        mealIngredients.append((name: strIngredient7, quantity: strMeasure7))
        
        strIngredient8 = try? mealContainer.decode(String.self, forKey: .strIngredient8)
        strMeasure8 = try? mealContainer.decode(String.self, forKey: .strMeasure8)
        mealIngredients.append((name: strIngredient8, quantity: strMeasure8))
        
        strIngredient9 = try? mealContainer.decode(String.self, forKey: .strIngredient9)
        strMeasure9 = try? mealContainer.decode(String.self, forKey: .strMeasure9)
        mealIngredients.append((name: strIngredient9, quantity: strMeasure9))
        
        strIngredient10 = try? mealContainer.decode(String.self, forKey: .strIngredient10)
        strMeasure10 = try? mealContainer.decode(String.self, forKey: .strMeasure10)
        mealIngredients.append((name: strIngredient10, quantity: strMeasure10))
        
        strIngredient11 = try? mealContainer.decode(String.self, forKey: .strIngredient11)
        strMeasure11 = try? mealContainer.decode(String.self, forKey: .strMeasure11)
        mealIngredients.append((name: strIngredient11, quantity: strMeasure11))
        
        strIngredient12 = try? mealContainer.decode(String.self, forKey: .strIngredient12)
        strMeasure12 = try? mealContainer.decode(String.self, forKey: .strMeasure12)
        mealIngredients.append((name: strIngredient12, quantity: strMeasure12))
        
        strIngredient13 = try? mealContainer.decode(String.self, forKey: .strIngredient13)
        strMeasure13 = try? mealContainer.decode(String.self, forKey: .strMeasure13)
        mealIngredients.append((name: strIngredient13, quantity: strMeasure13))
        
        strIngredient14 = try? mealContainer.decode(String.self, forKey: .strIngredient14)
        strMeasure14 = try? mealContainer.decode(String.self, forKey: .strMeasure14)
        mealIngredients.append((name: strIngredient14, quantity: strMeasure14))
        
        strIngredient15 = try? mealContainer.decode(String.self, forKey: .strIngredient15)
        strMeasure15 = try? mealContainer.decode(String.self, forKey: .strMeasure15)
        mealIngredients.append((name: strIngredient15, quantity: strMeasure15))
        
        strIngredient16 = try? mealContainer.decode(String.self, forKey: .strIngredient16)
        strMeasure16 = try? mealContainer.decode(String.self, forKey: .strMeasure16)
        mealIngredients.append((name: strIngredient16, quantity: strMeasure16))
        
        strIngredient17 = try? mealContainer.decode(String.self, forKey: .strIngredient17)
        strMeasure17 = try? mealContainer.decode(String.self, forKey: .strMeasure17)
        mealIngredients.append((name: strIngredient17, quantity: strMeasure17))
        
        strIngredient18 = try? mealContainer.decode(String.self, forKey: .strIngredient18)
        strMeasure18 = try? mealContainer.decode(String.self, forKey: .strMeasure18)
        mealIngredients.append((name: strIngredient18, quantity: strMeasure18))
        
        strIngredient19 = try? mealContainer.decode(String.self, forKey: .strIngredient19)
        strMeasure19 = try? mealContainer.decode(String.self, forKey: .strMeasure19)
        mealIngredients.append((name: strIngredient19, quantity: strMeasure19))
        
        strIngredient20 = try? mealContainer.decode(String.self, forKey: .strIngredient20)
        strMeasure20 = try? mealContainer.decode(String.self, forKey: .strMeasure20)
        mealIngredients.append((name: strIngredient20, quantity: strMeasure20))
    }
}
