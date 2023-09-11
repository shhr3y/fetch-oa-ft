//
//  MealDBRequest.swift
//  fetch-oa
//
//  Created by Shrey Gupta on 9/10/23.
//

import Foundation

/// Variables instantiation and private initialization method
// Set URLComponents: baseURL
fileprivate struct Constants {
    static let scheme = "https"
    static let host = "themealdb.com"
}

/// Handle different query use cases. Reference: https://themealdb.com/api.php @ Sept 2023
/// - filter: return all meals based on attribute (e.g. area, category)
/// - search: return meal details based on name
/// - lookup: return meal details based on id
/// - random: return a random meal's details
/// - randomSelection: return a selection of 10 random meals
/// - categories: return meal categories
/// - list: return list of attributes (e.g. area, category)
enum Endpoint: String, CaseIterable {
    case filter = "filter.php"
    case search = "search.php"
    case lookup = "lookup.php"
    case random = "random.php"
    case randomSelection = "randomselection.php"
    case categories = "categories.php"
    case list = "list.php"
}



/// Class to build a HTTP request to the MealDB API
final class MealDBRequest {
    // MARK: - Variables
    
    private let path: String
    private let queryItems: [URLQueryItem]
    
    // Build URL using URLComponents
    public var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.scheme
        urlComponents.host = Constants.host
        urlComponents.path = path
        if !queryItems.isEmpty{
            urlComponents.queryItems = queryItems
        }
        // Retrieve url from URLComponents
        return urlComponents.url
    }
    
    // MARK: - Init
    
    /// Private init to set endpoint and parameters
    /// - Parameters
    ///     - endpoint: type of endpoint based on Endpoint enum
    ///     - (optional) queryItems: additional parameters
    init (endpoint: Endpoint, queryItems: [String:String] = [String: String]()) {
        self.path = "/api/json/v1/1/" + endpoint.rawValue
        
        // Store parameters as list of URLQueryItem
        self.queryItems = queryItems.map {
            return URLQueryItem(name: "\($0)", value: "\($1)")
        }
    }
}
