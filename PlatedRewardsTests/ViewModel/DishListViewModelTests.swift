//
//  DishListViewModelTests.swift
//  PlatedRewardsTests
//
//  Created by Rachit Prajapati on 9/12/24.
//

import XCTest
@testable import PlatedRewards

class DishListViewModelTests: XCTestCase {
    
    var viewModel: DishListViewModel!
    var mockRepository: MockDishRepository!
    
    let json = """
    {
        "idMeal": "52772",
        "strMeal": "Teriyaki Chicken Casserole",
        "strMealThumb": "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg"
    }
    """.data(using: .utf8)!

    override func setUp() {
        super.setUp()
        mockRepository = MockDishRepository()
        viewModel = DishListViewModel(dishListRepository: mockRepository)
    }
    
    override func tearDown() {
        mockRepository = nil
        viewModel = nil
        super.tearDown()
    }
    
    // Test for successful data fetching
    func testBatchFetchSuccess() async {
        let decoder = JSONDecoder()
        let dish = try? decoder.decode(Dish.self, from: json)
        
        
        mockRepository.mockDishes = [dish!]
        mockRepository.mockCategories = ["Dessert", "Main Course"]
        mockRepository.mockAreas = ["USA", "UK"]
        
        // Call batchFetch method
        await viewModel.batchFetch()
        
        // Asserting state changes and data
        XCTAssertEqual(viewModel.state, .loaded([dish!]))
        XCTAssertEqual(viewModel.categories.count, 2)
        XCTAssertEqual(viewModel.areas.count, 2)
        XCTAssertFalse(viewModel.dishes.isEmpty)
        XCTAssertEqual(viewModel.dishes.first?.name, "Teriyaki Chicken Casserole")
    }
    
    // Test for failed data fetching
    func testBatchFetchFailure() async {
        // Error scenario
        mockRepository.shouldReturnError = true
        
        // Call batchFetch method
        await viewModel.batchFetch()
        
        // Assert state changes
        XCTAssertEqual(viewModel.state, .error("Failed to load data: Failed to convert the data."))
    }
    
    // Test for empty dishes response
    func testBatchFetchEmptyDishes() async {
        // Data with empty dishes
        mockRepository.mockDishes = []
        
        // Call batchFetch method
        await viewModel.batchFetch()
        
        // Assert state changes
        XCTAssertEqual(viewModel.state, .empty)
        XCTAssertTrue(viewModel.dishes.isEmpty)
    }
}
