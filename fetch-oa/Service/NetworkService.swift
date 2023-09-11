//
//  NetworkService.swift
//  fetch-oa
//
//  Created by Shrey Gupta on 9/1/23.
//

import Foundation

class NetworkService {
    static var shared = NetworkService()
    
    // MARK: - Init
    private init() {}
    
    // MARK: - Helper Functions
    
    /// function to fetch menu items by category.
    /// - Parameters:
    ///   - category: MealCategory type
    ///   - completion: callback handler for response
    func fetchMenuItems(byCategory category: MealCategory, completion: @escaping (Result<[MenuItem], NetworkServiceError>) -> Void) {
        // create MealDBRequest based on function parameters.
        let request = MealDBRequest(endpoint: .filter, queryItems: ["c": category.rawValue])
        
        // create URLRequest from request
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(.urlRequestBuildFail))
            return
        }
        
        // create URLsession dataTask
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            // Handling any URLSession error
            if let error {
                completion(.failure(.urlSessionErrorReturned(error: error)))
                return
            }
            
            // Handling bad response
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponseReturned))
                return
            }
            
            // Decode response as `MenuItemResponse` response type
            if let data, let items = try? JSONDecoder().decode(MenuItemResponse.self, from: data) {
                // Calls completion handler with decoded data.
                completion(.success(items.meals))
                
                return
            }
            
            // Throw error if decoding failed.
            completion(.failure(.decodingErrorReturned))
        })
        
        task.resume()
    }
    
    
    /// function to fetch item details based on item id.
    /// - Parameters:
    ///   - id: id for meal which needs to be fetched
    ///   - completion: callback handler for response
    func fetchItemDetails(withItemId id: String, completion: @escaping (Result<MenuItemDetail, NetworkServiceError>) -> Void) {
        // create MealDBRequest based on function parameters.
        let request = MealDBRequest(endpoint: .lookup, queryItems: ["i": id])
        
        // create URLRequest from request
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(.urlRequestBuildFail))
            return
        }
        
        // create URLsession dataTask
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            // Handling any URLSession error
            if let error {
                completion(.failure(.urlSessionErrorReturned(error: error)))
                return
            }
            
            // Handling bad response
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponseReturned))
                return
            }
            
            // Decode response as `MenuItemDetailResponse` response type
            if let data, let item = try? JSONDecoder().decode(MenuItemDetailResponse.self, from: data), let meal = item.meals.first {
                // Calls completion handler with decoded data.
                completion(.success(meal))
                
                return
            }
            
            // Throw error if decoding failed.
            completion(.failure(.decodingErrorReturned))
        })
        
        // Start URLSession dataTask
        task.resume()
    }
    
    /// Function to build URLSession with GET method
    /// - Parameters
    ///     - request: MealDBRequest type
    ///  - Returns
    ///     - request: URLRequest
    private func request(from request: MealDBRequest) -> URLRequest? {
        
        // Retrieve URL from MealdbRequest
        guard let url = request.url else {
            print("Error: Invalid URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return request
        
    }
}


/// Custom errors
/// - urlRequestBuildFail: Failed to build URLRequest
/// - urlSessionErrorReturned: Error was returned when building URLSession
/// - invalidResponseReturned: Bad response returned from API
extension NetworkService {
    enum NetworkServiceError: Error {
        case urlRequestBuildFail
        case urlSessionErrorReturned(error: Error)
        case invalidResponseReturned
        case decodingErrorReturned
    }
}
