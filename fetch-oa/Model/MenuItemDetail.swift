//
//  MenuItemDetail.swift
//  fetch-oa
//
//  Created by Shrey Gupta on 9/1/23.
//

import Foundation


/// Response for fetchItemDetail endpoint.
class MenuItemDetailResponse: Decodable {
    let meals: [MenuItemDetail]
}


/// Model for menu item detailed.
class MenuItemDetail: Decodable {
    let id: String
    let mealName: String
    let instructions: String
    let category: MealCategory?
    let thumbnailURLString: String
    let youtubeURLString: String
    let recipeSource: String?
    let imageSource: String?
    var ingredients = [String: String]()
    
    
    /// Using coding keys to have simpler variable names.
    enum CodingKeys: String, CodingKey {
        case id =                 "idMeal"
        case mealName =           "strMeal"
        case instructions =       "strInstructions"
        case thumbnailURLString = "strMealThumb"
        case youtubeURLString =   "strYoutube"
        case imageSource =        "strImageSource"
        case recipeSource =       "strSource"
        case category =           "strCategory"
        case ingredient1 =        "strIngredient1"
        case ingredient2 =        "strIngredient2"
        case ingredient3 =        "strIngredient3"
        case ingredient4 =        "strIngredient4"
        case ingredient5 =        "strIngredient5"
        case ingredient6 =        "strIngredient6"
        case ingredient7 =        "strIngredient7"
        case ingredient8 =        "strIngredient8"
        case ingredient9 =        "strIngredient9"
        case ingredient10 =       "strIngredient10"
        case ingredient11 =       "strIngredient11"
        case ingredient12 =       "strIngredient12"
        case ingredient13 =       "strIngredient13"
        case ingredient14 =       "strIngredient14"
        case ingredient15 =       "strIngredient15"
        case ingredient16 =       "strIngredient16"
        case ingredient17 =       "strIngredient17"
        case ingredient18 =       "strIngredient18"
        case ingredient19 =       "strIngredient19"
        case ingredient20 =       "strIngredient20"
        case measurement1 =       "strMeasure1"
        case measurement2 =       "strMeasure2"
        case measurement3 =       "strMeasure3"
        case measurement4 =       "strMeasure4"
        case measurement5 =       "strMeasure5"
        case measurement6 =       "strMeasure6"
        case measurement7 =       "strMeasure7"
        case measurement8 =       "strMeasure8"
        case measurement9 =       "strMeasure9"
        case measurement10 =      "strMeasure10"
        case measurement11 =      "strMeasure11"
        case measurement12 =      "strMeasure12"
        case measurement13 =      "strMeasure13"
        case measurement14 =      "strMeasure14"
        case measurement15 =      "strMeasure15"
        case measurement16 =      "strMeasure16"
        case measurement17 =      "strMeasure17"
        case measurement18 =      "strMeasure18"
        case measurement19 =      "strMeasure19"
        case measurement20 =      "strMeasure20"
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id =                 try container.decode(String.self, forKey: .id)
        mealName =           try container.decode(String.self, forKey: .mealName)
        instructions =       try container.decode(String.self, forKey: .instructions)
        category =           MealCategory(rawValue: try container.decode(String.self, forKey: .category))
        thumbnailURLString = try container.decode(String.self, forKey: .thumbnailURLString)
        youtubeURLString =   try container.decode(String.self, forKey: .youtubeURLString)
        imageSource =        try container.decode(String?.self, forKey: .imageSource)
        recipeSource =       try container.decode(String?.self, forKey: .recipeSource)
        
        
        // adding all ingredients and measurement inside a dictionary.
        // first checking if ingredient and measurement available in json. if yes, adding it as [ingredient: measurement] into measurements dictionary.
        if let key = try? container.decode(String.self, forKey: .ingredient1),
           let value = try? container.decode(String.self, forKey: .measurement1) {
            ingredients[key] = value
        }
        
        if let key = try? container.decode(String.self, forKey: .ingredient2),
           let value = try? container.decode(String.self, forKey: .measurement2) {
            ingredients[key] = value
        }
        
        if let key = try? container.decode(String.self, forKey: .ingredient3),
           let value = try? container.decode(String.self, forKey: .measurement3) {
            ingredients[key] = value
        }
        
        if let key = try? container.decode(String.self, forKey: .ingredient4),
           let value = try? container.decode(String.self, forKey: .measurement4) {
            ingredients[key] = value
        }
        
        if let key = try? container.decode(String.self, forKey: .ingredient5),
           let value = try? container.decode(String.self, forKey: .measurement5) {
            ingredients[key] = value
        }
        
        if let key = try? container.decode(String.self, forKey: .ingredient6),
           let value = try? container.decode(String.self, forKey: .measurement6) {
            ingredients[key] = value
        }
        
        if let key = try? container.decode(String.self, forKey: .ingredient7),
           let value = try? container.decode(String.self, forKey: .measurement7) {
            ingredients[key] = value
        }
        
        if let key = try? container.decode(String.self, forKey: .ingredient8),
           let value = try? container.decode(String.self, forKey: .measurement8) {
            ingredients[key] = value
        }
        
        if let key = try? container.decode(String.self, forKey: .ingredient9),
           let value = try? container.decode(String.self, forKey: .measurement9) {
            ingredients[key] = value
        }
        
        if let key = try? container.decode(String.self, forKey: .ingredient10),
           let value = try? container.decode(String.self, forKey: .measurement10) {
            ingredients[key] = value
        }
        
        if let key = try? container.decode(String.self, forKey: .ingredient11),
           let value = try? container.decode(String.self, forKey: .measurement11) {
            ingredients[key] = value
        }
        
        if let key = try? container.decode(String.self, forKey: .ingredient12),
           let value = try? container.decode(String.self, forKey: .measurement12) {
            ingredients[key] = value
        }
        
        if let key = try? container.decode(String.self, forKey: .ingredient13),
           let value = try? container.decode(String.self, forKey: .measurement13) {
            ingredients[key] = value
        }
        
        if let key = try? container.decode(String.self, forKey: .ingredient14),
           let value = try? container.decode(String.self, forKey: .measurement14) {
            ingredients[key] = value
        }
        
        if let key = try? container.decode(String.self, forKey: .ingredient15),
           let value = try? container.decode(String.self, forKey: .measurement15) {
            ingredients[key] = value
        }
        
        if let key = try? container.decode(String.self, forKey: .ingredient16),
           let value = try? container.decode(String.self, forKey: .measurement16) {
            ingredients[key] = value
        }
        
        if let key = try? container.decode(String.self, forKey: .ingredient17),
           let value = try? container.decode(String.self, forKey: .measurement17) {
            ingredients[key] = value
        }
        
        if let key = try? container.decode(String.self, forKey: .ingredient18),
           let value = try? container.decode(String.self, forKey: .measurement18) {
            ingredients[key] = value
        }
        
        if let key = try? container.decode(String.self, forKey: .ingredient19),
           let value = try? container.decode(String.self, forKey: .measurement19) {
            ingredients[key] = value
        }
        
        if let key = try? container.decode(String.self, forKey: .ingredient20),
           let value = try? container.decode(String.self, forKey: .measurement20) {
            ingredients[key] = value
        }
        
        // checking for empty strings. if found, it is removed from the dictionary.
        for (key, val) in ingredients {
            if key.trimmingCharacters(in: .whitespaces) == "" || val.trimmingCharacters(in: .whitespaces) == "" {
                ingredients.removeValue(forKey: key)
            }
        }
    }
    
    
    var youtubeVideoID: String? {
        if let index = youtubeURLString.range(of: "=")?.upperBound {
            return String(youtubeURLString.suffix(from: index))
        } else {
            return nil
        }
    }
}


