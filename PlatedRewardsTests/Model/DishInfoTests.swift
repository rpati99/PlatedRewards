//
//  DishInfoTests.swift
//  PlatedRewardsTests
//
//  Created by Rachit Prajapati on 9/12/24.
//

import XCTest
@testable import PlatedRewards

class DishInfoTests: XCTestCase {

    // Below are sample JSON covering some testcases
    
    // Sample JSON for a valid DishInfo object with properly escaped newlines
    let validDishInfoJSON = """
    {
        "idMeal": "52772",
        "strMeal": "Test Dish",
        "strMealThumb": "https://www.example.com/testdish.jpg",
        "strInstructions": "Step 1\\r\\nStep 2\\r\\nStep 3",
        "strYoutube": "https://www.youtube.com/watch?v=example",
        "strSource": "https://www.example.com"
    }
    """

    // Sample JSON with missing optional fields (e.g., youtubeURL and sourceURL)
    let missingFieldsJSON = """
    {
        "idMeal": "52772",
        "strMeal": "Test Dish",
        "strMealThumb": "https://www.example.com/testdish.jpg",
        "strInstructions": "Step 1\\r\\nStep 2\\r\\nStep 3"
    }
    """

    // Invalid JSON with a missing required field     
    let malformedDishInfoJSON = """
    {
        "strMeal": 12345,
        "strMealThumb": "https://www.example.com/testdish.jpg",
        "strInstructions": "Step 1\\r\\nStep 2\\r\\nStep 3"
    }
    """.data(using: .utf8)!
    
    // Empty instructions
    let jsonWithEmptyInstructions = """
    {
        "idMeal": "52772",
        "strMeal": "Test Dish",
        "strMealThumb": "https://www.example.com/testdish.jpg",
        "strInstructions": ""
    }
    """

    // Test decoding of a valid JSON
    func testDecodingValidDishInfo() throws {
        let jsonData = Data(validDishInfoJSON.utf8)
        let decoder = JSONDecoder()
        let dishInfo = try decoder.decode(DishInfo.self, from: jsonData)
        
        XCTAssertEqual(dishInfo.id, "52772")
        XCTAssertEqual(dishInfo.name, "Test Dish")
        XCTAssertEqual(dishInfo.thumbnailURL?.absoluteString, "https://www.example.com/testdish.jpg")
        XCTAssertEqual(dishInfo.instructions, ["Step 1", "Step 2", "Step 3"])
        XCTAssertEqual(dishInfo.youtubeURL?.absoluteString, "https://www.youtube.com/watch?v=example")
        XCTAssertEqual(dishInfo.sourceURL?.absoluteString, "https://www.example.com")
    }

    // Test decoding of JSON with missing optional fields
    func testDecodingMissingFields() throws {
        let jsonData = Data(missingFieldsJSON.utf8)
        let decoder = JSONDecoder()
        let dishInfo = try decoder.decode(DishInfo.self, from: jsonData)

        XCTAssertEqual(dishInfo.id, "52772")
        XCTAssertEqual(dishInfo.name, "Test Dish")
        XCTAssertEqual(dishInfo.thumbnailURL?.absoluteString, "https://www.example.com/testdish.jpg")
        XCTAssertEqual(dishInfo.instructions, ["Step 1", "Step 2", "Step 3"])
        XCTAssertNil(dishInfo.youtubeURL)  // Youtube URL is optional here
        XCTAssertNil(dishInfo.sourceURL)   // Source URL is optional here
    }

    // Test decoding of invalid JSON
    func testDecodingInvalidDishInfo() {
        
        XCTAssertThrowsError(try JSONDecoder().decode(DishInfo.self, from: malformedDishInfoJSON)) { error in
            guard case DecodingError.typeMismatch = error else {
                XCTFail("Expected type mismatch error, but got: \(error)")
                return
            }
        }
    }
    
    // Test decoding of empty instructions
    func testEmptyInstructions() throws {
        let jsonData = Data(jsonWithEmptyInstructions.utf8)
        let decoder = JSONDecoder()
        let dishInfo = try decoder.decode(DishInfo.self, from: jsonData)
        
        XCTAssertTrue(dishInfo.instructions.isEmpty)
    }
    
    
    
}
