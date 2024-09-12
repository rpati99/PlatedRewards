//
//  DishInfoTests.swift
//  PlatedRewardsTests
//
//  Created by Rachit Prajapati on 9/12/24.
//

import XCTest
@testable import PlatedRewards

class DishInfoTests: XCTestCase {

    func testDishInfoDecoding_withValidData() throws {
        // JSON response representing a valid dish
        let json = """
        {
            "idMeal": "12345",
            "strMeal": "Chicken Curry",
            "strMealThumb": "https://example.com/image.jpg",
            "strInstructions": "Step 1: Cook the chicken\\r\\nStep 2: Add spices",
            "strYoutube": "https://youtube.com/watch?v=example",
            "strSource": "https://example.com/recipe",
            "strIngredient1": "Chicken",
            "strMeasure1": "500g",
            "strIngredient2": "Salt",
            "strMeasure2": "1 tsp"
        }
        """.data(using: .utf8)!

        // Decoding the JSON into a DishInfo object
        let decoder = JSONDecoder()
        let dishInfo = try decoder.decode(DishInfo.self, from: json)

        // The decoded object should match the expected values
        XCTAssertEqual(dishInfo.id, "12345", "Dish ID should match")
        XCTAssertEqual(dishInfo.name, "Chicken Curry", "Dish name should match")
        XCTAssertEqual(dishInfo.thumbnailURL?.absoluteString, "https://example.com/image.jpg", "Thumbnail URL should match")
        XCTAssertEqual(dishInfo.instructions, ["Step 1: Cook the chicken\r\nStep 2: Add spices"], "Instructions should be parsed correctly")
        XCTAssertEqual(dishInfo.youtubeURL?.absoluteString, "https://youtube.com/watch?v=example", "YouTube URL should match")
        XCTAssertEqual(dishInfo.sourceURL?.absoluteString, "https://example.com/recipe", "Source URL should match")

        // The ingredients and measurements should be decoded correctly
        XCTAssertEqual(dishInfo.ingredients.count, 2, "There should be two ingredients")
        XCTAssertEqual(dishInfo.ingredients[0].name, "Chicken", "First ingredient should be Chicken")
        XCTAssertEqual(dishInfo.ingredients[0].quantity, "500g", "First ingredient quantity should match")
        XCTAssertEqual(dishInfo.ingredients[1].name, "Salt", "Second ingredient should be Salt")
        XCTAssertEqual(dishInfo.ingredients[1].quantity, "1 tsp", "Second ingredient quantity should match")
    }

    func testDishInfoDecoding_withEmptyIngredients() throws {
        // JSON with empty ingredients and measurements
        let json = """
        {
            "idMeal": "67890",
            "strMeal": "Beef Stew",
            "strMealThumb": "https://example.com/image.jpg",
            "strInstructions": "Just cook it!",
            "strIngredient1": "",
            "strMeasure1": "",
            "strIngredient2": "",
            "strMeasure2": ""
        }
        """.data(using: .utf8)!

        // Decoding the JSON
        let decoder = JSONDecoder()
        let dishInfo = try decoder.decode(DishInfo.self, from: json)

        // Decoded object should have no ingredients
        XCTAssertTrue(dishInfo.ingredients.isEmpty, "Ingredients should be empty when not provided")
    }

    func testDishInfoDecoding_withMalformedData() {
        // Malformed JSON response (missing closing bracket)
        let malformedJSON = """
        {
            "idMeal": "12345",
            "strMeal": "Chicken Curry",
            "strInstructions": "Invalid JSON missing closing brace
        """.data(using: .utf8)!

        // Attempting to decode the malformed JSON
        let decoder = JSONDecoder()

        // Decoding should throw a DecodingError
        XCTAssertThrowsError(try decoder.decode(DishInfo.self, from: malformedJSON), "Expected decoding to fail with malformed JSON") { error in
            XCTAssertTrue(error is DecodingError, "Error should be a DecodingError")
        }
    }

    func testDishInfoDecoding_withNoInstructions() throws {
        // A sample JSON without instructions
        let json = """
        {
            "idMeal": "12345",
            "strMeal": "Chicken Curry",
            "strMealThumb": "https://example.com/image.jpg"
        }
        """.data(using: .utf8)!

        // Decoding the JSON
        let decoder = JSONDecoder()
        let dishInfo = try decoder.decode(DishInfo.self, from: json)

        // Instructions should be an empty array if not provided
        XCTAssertTrue(dishInfo.instructions.isEmpty, "Instructions should default to an empty array")
    }

    func testDishInfoDecoding_withOnlyYouTubeURL() throws {
        // SON with just a YouTube URL
        let json = """
        {
            "idMeal": "98765",
            "strMeal": "Fish Tacos",
            "strMealThumb": "https://example.com/fish.jpg",
            "strYoutube": "https://youtube.com/watch?v=fishyvideo"
        }
        """.data(using: .utf8)!

        // Decoding the JSON
        let decoder = JSONDecoder()
        let dishInfo = try decoder.decode(DishInfo.self, from: json)

        // Only the YouTube URL should be present, and other optional fields should be nil
        XCTAssertEqual(dishInfo.youtubeURL?.absoluteString, "https://youtube.com/watch?v=fishyvideo", "YouTube URL should match")
        XCTAssertNil(dishInfo.sourceURL, "Source URL should be nil")
    }
}
