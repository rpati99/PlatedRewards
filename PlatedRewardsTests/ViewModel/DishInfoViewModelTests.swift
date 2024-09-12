//
//  DishInfoViewModelTests.swift
//  PlatedRewardsTests
//
//  Created by Rachit Prajapati on 9/12/24.
//

import XCTest
@testable import PlatedRewards

class DishInfoViewModelTests: XCTestCase {
    var mockRepository: MockDishRepository!
    var viewModel: DishInfoViewModel!
    
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
    
    override func setUp() {
        super.setUp()
        mockRepository = MockDishRepository()
        viewModel = DishInfoViewModel(mealRepository: mockRepository)
    }
    
    override func tearDown() {
        mockRepository = nil
        viewModel = nil
        super.tearDown()
    }
    
    // Test fetching dish info successfully
    func testFetchDishInfoSuccess() async throws {
        // Arranging
        let jsonData = Data(validDishInfoJSON.utf8)
        let decoder = JSONDecoder()
        let mockDishInfo = try decoder.decode(DishInfo.self, from: jsonData)
        mockRepository.mockDishInfo = mockDishInfo
        
        await viewModel.fetchDishInfo(dishId: "12345")
        
        // Assert
        XCTAssertEqual(viewModel.dishInfo?.name, "Test Dish")
        XCTAssertEqual(viewModel.dishInfo?.instructions, ["Step 1", "Step 2", "Step 3"])
        XCTAssertEqual(viewModel.state, .loaded(mockDishInfo))
    }
    
    // Test fetching dish info failure
    func testFetchDishInfoFailure() async {
        // Arrange
        mockRepository.shouldReturnError = true
        await viewModel.fetchDishInfo(dishId: "12345")
        
        // Assert
        XCTAssertEqual(viewModel.state, .error("Failed to load dish details: Failed to convert the data."))
    }
}
