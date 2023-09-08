//
//  MenuItem.swift
//  fetch-oa
//
//  Created by Shrey Gupta on 9/1/23.
//

import Foundation

/// Response for fetchSelectedCategory endpoint.
class MenuItemResponse: Codable {
    let meals: [MenuItem]
}


/// Model for menu item.
class MenuItem: Codable {
    let name: String
    let thumbnail: String
    let id: String
    
    /// Using coding keys to have simpler variable names.
    private enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case thumbnail = "strMealThumb"
        case id = "idMeal"
    }
}
