//
//  DishNetworkServiceTests.swift
//  PlatedRewardsTests
//
//  Created by Rachit Prajapati on 9/12/24.
//

import XCTest
@testable import PlatedRewards

class DishNetworkServiceTests: XCTestCase {

    var mockNetworkService: MockDishNetworkService!
    var repository: DishRepository!
    
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

    func testFetchDishesSuccess() async throws {
        
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
        let mockDish = try decoder.decode(Dish.self, from: json)
        
        mockNetworkService.mockDishes = [mockDish]
        
        // Fetch dishes from repository
        let dishes = try await repository.fetchDishes(category: "Dessert", area: nil)
        
        // Asserting the result
        XCTAssertEqual(dishes.count, 1)
        XCTAssertEqual(dishes.first?.name, "Teriyaki Chicken Casserole")
    }

    func testFetchDishesFailure() async throws {
        // Error scenario
        mockNetworkService.shouldReturnError = true
        
        do {
            _ = try await repository.fetchDishes(category: "Dessert", area: nil)
            XCTFail("Expected an error but did not get one")
        } catch {
            XCTAssertEqual(error as? NetworkError, NetworkError.requestFailed(statusCode: 500))
        }
    }

    func testFetchDishInfoSuccess() async throws {
        // JSON data
        
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
        let jsonData = Data(validDishInfoJSON.utf8)
        let decoder = JSONDecoder()
        let mockDishInfo = try decoder.decode(DishInfo.self, from: jsonData)
        
        mockNetworkService.mockDishInfo = mockDishInfo
        
        // Fetching dish info from repository
        let dishInfo = try await repository.fetchDishInfo(id: "1")
        
        // Assert the result
        XCTAssertEqual(dishInfo.name, "Test Dish")
        XCTAssertEqual(dishInfo.instructions.count, 3)
    }

    func testFetchDishInfoFailure() async throws {
        // Error scenario
        mockNetworkService.shouldReturnError = true
        
        do {
            _ = try await repository.fetchDishInfo(id: "1")
            XCTFail("Expected an error but did not get one")
        } catch {
            XCTAssertEqual(error as? NetworkError, NetworkError.dataConversionFailure)
        }
    }

    func testFetchCategoriesSuccess() async throws {
        // Preparing data
        mockNetworkService.mockCategories = ["Dessert", "Main Course"]
        
        // Fetching categories from repository
        let categories = try await repository.fetchCategories()
        
        // Assert the result
        XCTAssertEqual(categories.count, 2)
        XCTAssertEqual(categories.first, "Dessert")
    }

    func testFetchAreasSuccess() async throws {
        // Preparing data
        mockNetworkService.mockAreas = ["USA", "UK"]
        
        // Fetch areas from repository
        let areas = try await repository.fetchAreas()
        
        // Assert the result
        XCTAssertEqual(areas.count, 2)
        XCTAssertEqual(areas.first, "USA")
    }
}
