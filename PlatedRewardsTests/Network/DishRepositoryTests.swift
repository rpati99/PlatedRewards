//
//  DishRepositoryTests.swift
//  PlatedRewardsTests
//
//  Created by Rachit Prajapati on 9/12/24.
//

import XCTest
@testable import PlatedRewards

class DishRepositoryTests: XCTestCase {
    var mockNetworkService: MockDishNetworkService!
    var repository: DishRepository!
    
    // Sample JSON API response
    let json = """
    {
        "idMeal": "12345",
        "strMeal": "Test Dish",
        "strMealThumb": "https://example.com/image.jpg",
        "strInstructions": "Step 1\\r\\nStep 2",
        "strYoutube": "https://youtube.com/watch?v=example",
        "strSource": "https://example.com/recipe"
    }
    """.data(using: .utf8)!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockDishNetworkService()
        repository = DishRepository(networkService: mockNetworkService)
    }
    
    override func tearDown() {
        mockNetworkService = nil
        repository = nil
        super.tearDown()
    }
    
    // Testing fetching dishes successfully
    func testFetchDishesSuccess() async throws {
        // ample JSON data
        let json = """
        {
            "idMeal": "52772",
            "strMeal": "Teriyaki Chicken Casserole",
            "strMealThumb": "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg"
        }
        """.data(using: .utf8)!
        
        // Decoding the data into a Dish object
        let decoder = JSONDecoder()
        let mockDish = try decoder.decode(Dish.self, from: json)
        
        mockNetworkService.mockDishes = [mockDish]

        let dishes = try await repository.fetchDishes(category: "Dessert", area: nil)

        // Assert
        XCTAssertEqual(dishes.count, 1)
        XCTAssertEqual(dishes.first?.name, "Teriyaki Chicken Casserole")
    }

    // Test fetching dishes failure
    func testFetchDishesFailure() async throws {
        // Arrange
        mockNetworkService.shouldReturnError = true

        // Assert
        do {
            _ = try await repository.fetchDishes(category: "Dessert", area: nil)
            XCTFail("Expected error, but no error was thrown.")
        } catch {
            XCTAssertTrue(error is NetworkError, "Expected NetworkError but got \(error)")
        }
    }

    // Testing fetching categories successfully
    func testFetchCategoriesSuccess() async throws {
        // Arrange
        mockNetworkService.mockCategories = ["Dessert", "Entree"]
        let categories = try await repository.fetchCategories()

        // Assert
        XCTAssertEqual(categories, ["Dessert", "Entree"])
    }

    // Test fetching categories failure
    func testFetchCategoriesFailure() async throws {
        // Arrange
        mockNetworkService.shouldReturnError = true

        // Assert
        do {
            _ = try await repository.fetchCategories()
            XCTFail("Expected error, but no error was thrown.")
        } catch {
            XCTAssertTrue(error is NetworkError, "Expected NetworkError but got \(error)")
        }
    }

    // Test fetching dish info successfully
    func testFetchDishInfoSuccess() async throws {

        let decoder = JSONDecoder()

        let mockDishInfo = try decoder.decode(DishInfo.self, from: json)
        
        mockNetworkService.mockDishInfo = mockDishInfo
        let dishInfo = try await repository.fetchDishInfo(id: "12345")

        // Assert
        XCTAssertEqual(dishInfo.name, "Test Dish")
        XCTAssertEqual(dishInfo.instructions, ["Step 1", "Step 2"])
    }

    // Test fetching dish info failure
    func testFetchDishInfoFailure() async throws {
        // Arrange
        mockNetworkService.shouldReturnError = true

        // Assert
        do {
            _ = try await repository.fetchDishInfo(id: "12345")
            XCTFail("Expected error, but no error was thrown.")
        } catch {
            XCTAssertTrue(error is NetworkError, "Expected NetworkError but got \(error)")
        }
    }
}
