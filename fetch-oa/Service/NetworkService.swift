//
//  NetworkService.swift
//  fetch-oa
//
//  Created by Shrey Gupta on 9/1/23.
//

import Foundation

let baseUrl = "https://themealdb.com/api/json/v1/1/"

class NetworkService {
    static var shared = NetworkService()
    
    func fetchMenuItems(byCategory category: MealCategory, completion: @escaping ([MenuItem]?, String?) -> Void) {
        let categoryUrlString = baseUrl + "filter.php?" + "c=\(category.rawValue)"
        
        guard let categoryUrl = URL(string: categoryUrlString) else {
            completion(nil, "Error initialising the string as url: \(categoryUrlString)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: categoryUrl, completionHandler: { (data, response, error) in
            if let error {
                completion(nil, "Error while fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(nil, "Error with the response, unexpected status code: \(response.debugDescription)")
                return
            }
            
            if let data, let items = try? JSONDecoder().decode(MenuItemResponse.self, from: data) {
                completion(items.meals, nil)
            }
        })
        
        task.resume()
    }
    
    func fetchItemDetails(withItemId id: String, completion: @escaping (MenuItemDetail?, String?) -> Void) {
        let itemDetailUrlString = baseUrl + "lookup.php?" + "i=\(id)"
        
        guard let itemDetailUrl = URL(string: itemDetailUrlString) else {
            completion(nil, "Error initialising the string as url: \(itemDetailUrlString)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: itemDetailUrl, completionHandler: { (data, response, error) in
            if let error {
                completion(nil, "Error while fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(nil, "Error with the response, unexpected status code: \(response.debugDescription)")
                return
            }
            
            do {
                if let data {
                    let item = try JSONDecoder().decode(MenuItemDetailResponse.self, from: data)
                    completion(item.meals.first, nil)
                    
                }
            } catch {
                completion(nil, "Error occoured while parsing json object: \(error.localizedDescription)")
            }
        })
        
        task.resume()
    }
}
