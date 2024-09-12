//
//  EndToEndTests.swift
//  PlatedRewardsTests
//
//  Created by Rachit Prajapati on 9/12/24.
//

import XCTest
import SwiftUI
@testable import PlatedRewards

final class EndToEndTests: XCTestCase {

    var appCoordinator: AppCoordinator!
    var dishListViewModel: DishListViewModel!
    var dishInfoViewModel: DishInfoViewModel!
    
    // Assuming a valid dish for the test
    let json = """
    {
        "idMeal": "52772",
        "strMeal": "Teriyaki Chicken Casserole",
        "strMealThumb": "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg"
    }
    """.data(using: .utf8)!

    override func setUp() {
        super.setUp()
        appCoordinator = AppCoordinator()
        dishListViewModel = DishListViewModel()
        dishInfoViewModel = DishInfoViewModel()
    }

    override func tearDown() {
        appCoordinator = nil
        dishListViewModel = nil
        dishInfoViewModel = nil
        super.tearDown()
    }

    func testNavigationToDishDetail() async throws {
        // The navigationPath count should be 0
        XCTAssertEqual(appCoordinator.navigationPath.count, 0)
        
        // Decoding the data into a Dish object
        let decoder = JSONDecoder()
        let testDish = try decoder.decode(Dish.self, from: json)
        
        // Simulate fetching the dishes
        await dishListViewModel.batchFetch()

        // Trigger the navigation by selecting a dish
        appCoordinator.showDishDetail(for: testDish.id)
        
        // After navigation, the navigationPath count should increase by 1
        XCTAssertEqual(appCoordinator.navigationPath.count, 1)
    }

    func testGoBackAfterNavigation() async throws {
        // Decoding the data into a Dish object
        let decoder = JSONDecoder()
        let testDish = try decoder.decode(Dish.self, from: json)

        // Fetching of dishes
        await dishListViewModel.batchFetch()

        // Trigger the navigation by selecting a dish
        appCoordinator.showDishDetail(for: testDish.id)

        // NavigationPath count should be 1 after navigation
        XCTAssertEqual(appCoordinator.navigationPath.count, 1)

        // Simulate going back
        appCoordinator.goBack()

        // After goBack, the navigationPath count should be 0
        XCTAssertEqual(appCoordinator.navigationPath.count, 0)
    }

    func testBatchFetchLoadingState() async throws {
        // Ensuring the initial state is loading
        XCTAssertEqual(dishListViewModel.state, .loading)

        // Perform batch fetch
        await dishListViewModel.batchFetch()

        // Validate that state is either loaded or empty
        switch dishListViewModel.state {
        case .loaded(let dishes):
            XCTAssertFalse(dishes.isEmpty)
        case .empty:
            XCTAssertTrue(dishListViewModel.dishes.isEmpty)
        default:
            XCTFail("Unexpected state after batch fetch")
        }
    }

    func testFetchingDishInfo() async throws {
        // Valid dish ID for the test
        let testDishId = "53049"

        // Simulating fetching dish info
        await dishInfoViewModel.fetchDishInfo(dishId: testDishId)

        // Validating that the state is now loaded and contains the correct dish info
        switch dishInfoViewModel.state {
        case .loaded(let dish):
            XCTAssertEqual(dish.id, testDishId)
        case .error(let errorMessage):
            XCTFail("Failed to fetch dish info: \(errorMessage)")
        default:
            XCTFail("Unexpected state after fetching dish info")
        }
    }

    func testGoBackWithoutNavigation() {
        // NavigationPath should be empty
        XCTAssertEqual(appCoordinator.navigationPath.count, 0)

        // Trying to go back without navigating anywhere
        appCoordinator.goBack()

        // Ensure the navigationPath is still empty
        XCTAssertEqual(appCoordinator.navigationPath.count, 0)
    }
}
