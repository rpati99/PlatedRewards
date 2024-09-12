//
//  DishTests.swift
//  PlatedRewardsTests
//
//  Created by Rachit Prajapati on 9/12/24.
//

import XCTest
@testable import PlatedRewards

class DishTests: XCTestCase {
    
    func testDishDecoding() throws {
        // Sample JSON data
        let json = """
        {
            "idMeal": "52772",
            "strMeal": "Teriyaki Chicken Casserole",
            "strMealThumb": "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg"
        }
        """.data(using: .utf8)!
        
        // Decoding the data into a Dish object
        let decoder = JSONDecoder()
        let dish = try decoder.decode(Dish.self, from: json)
        
        // Assert that the decoded data matches expected values
        XCTAssertEqual(dish.id, "52772")
        XCTAssertEqual(dish.name, "Teriyaki Chicken Casserole")
        XCTAssertEqual(dish.thumbnailURL?.absoluteString, "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg/preview")
    }
    
    func testDishDecodingWithMissingValues() throws {
        // JSON data missing the meal name
        let json = """
        {
            "idMeal": "52772",
            "strMealThumb": "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg"
        }
        """.data(using: .utf8)!
        
        // Decoding the data into a Dish object
        let decoder = JSONDecoder()
        let dish = try decoder.decode(Dish.self, from: json)
        
        // Assert that default values are used when a field is missing
        XCTAssertEqual(dish.id, "52772")
        XCTAssertEqual(dish.name, "")
        XCTAssertEqual(dish.thumbnailURL?.absoluteString, "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg/preview")
    }
    
    func testDishDecodingWithInvalidURL() throws {
        // SON data with invalid thumbnail URL
        let json = """
        {
            "idMeal": "52772",
            "strMeal": "Teriyaki Chicken Casserole",
            "strMealThumb": "invalid-url"
        }
        """.data(using: .utf8)!
        
        // Decoding the data into a Dish object
        let decoder = JSONDecoder()
        let dish = try decoder.decode(Dish.self, from: json)
        
        // Assert that the URL is nil
        XCTAssertEqual(dish.id, "52772")
        XCTAssertEqual(dish.name, "Teriyaki Chicken Casserole")
        XCTAssertNil(dish.thumbnailURL)
    }
}
