//
//  MenuCategory.swift
//  fetch-oa
//
//  Created by Shrey Gupta on 9/1/23.
//

import Foundation


/// MealCategory: Enum for different types of categories, string value is used as key for API endpoints.
enum MealCategory: String, Codable {
    case vegetarian = "Vegetarian"
    case starter = "Starter"
    case breakfast = "Breakfast"
    case dessert = "Dessert"
    case miscellaneous = "Miscellaneous"
}
