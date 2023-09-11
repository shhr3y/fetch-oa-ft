//
//  fetch_oaTests.swift
//  fetch-oaTests
//
//  Created by Shrey Gupta on 9/10/23.
//

import XCTest
@testable import fetch_oa

/// Unit tests for basic app functionality
final class DessertMenuTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    // MARK: - MealDBRequest Tests
    /// Function to compare MealDBRequest with filter endpoint with actual endpoint
    func testBuildFilterUrl() {
        // Mock use filter endpoint
        let request = MealDBRequest(endpoint: .filter)
        
        // Check if built URL is equal to sample URL
        XCTAssertEqual(request.url, URL(string: "https://themealdb.com/api/json/v1/1/filter.php"))
    }
    
    /// Function to compare MealDBRequest with filter all desserts endpoint with actual endpoint
    func testBuildFilterDessertsUrl() {
        // Mock filter dessert meals
        let request = MealDBRequest(endpoint: .filter, queryItems: ["c" : "Dessert"])
        
        // Check if built URL is equal to sample URL
        XCTAssertEqual(request.url, URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"))
    }
    
    /// Function to compare MealDBRequest with lookup dessert detail based on id endpoint with actual endpoint
    func testBuildLookupDessertDetailUrl() {
        // Mock lookup idMeal 53049
        let request = MealDBRequest(endpoint: .lookup, queryItems: ["i" : "53049"])
        
        // Check if built URL is equal to sample URL
        XCTAssertEqual(request.url, URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=53049"))
    }
    
    // MARK: - NetworkService Tests
    /// Function to test NetworkService to get all items
    func testFilterDesserts() {
        var menuItems: [MenuItem] = []
        
        // create funtion expectation
        let expectation = XCTestExpectation(description: #function)
        
        // fetchMenuItems of category dessert from NetworkService
        NetworkService.shared.fetchMenuItems(byCategory: .dessert) { result in
            switch result {
            // Fulfill XCTestExpectation only when a valid response is returned
            case .success(let meals):
                menuItems = meals
                expectation.fulfill()
                
            case .failure:
                XCTFail("Test error: Dessert detail not retrieved")
            }
        }
        
        // Wait for mock run to be fulfilled
        wait(for: [expectation], timeout: 3.0)
        
        // Check if non empty array of meals is returned
        XCTAssert(menuItems.count > 0)
    }
    
    
    // Function to test NetworkService get item detail based on id: 53049
    func testLookupDessertDetail() {
        var menuItemDetail: MenuItemDetail? = nil
        
        // create funtion expectation
        let expectation = XCTestExpectation(description: #function)
        
        // fetchItemDetails with item id 53049 from NetworkService
        NetworkService.shared.fetchItemDetails(withItemId: "53049") { result in
            switch result {
            // Fulfill XCTestExpectation only when a valid response is returned
            case .success(let meal):
                menuItemDetail = meal
                expectation.fulfill()
                
            case .failure:
                XCTFail("Test error: Dessert detail not retrieved")
            }
        }
        
        // Wait for mock run to be fulfilled
        wait(for: [expectation], timeout: 3.0)
        
        // Check if item detail returned matches with meal name "Apam balik".
        XCTAssertEqual(menuItemDetail?.mealName, "Apam balik")
    }
}
