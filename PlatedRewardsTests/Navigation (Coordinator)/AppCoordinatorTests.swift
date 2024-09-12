//
//  AppCoordinatorTests.swift
//  PlatedRewardsTests
//
//  Created by Rachit Prajapati on 9/12/24.
//

import XCTest
import SwiftUI
@testable import PlatedRewards

final class AppCoordinatorTests: XCTestCase {
    
    var coordinator: AppCoordinator!
    
    override func setUp() {
        super.setUp()
        coordinator = AppCoordinator()
    }
    
    override func tearDown() {
        coordinator = nil
        super.tearDown()
    }
    
    // Test initial state of the navigation path
    func testCoordinatorInitialization() {
        XCTAssertTrue(coordinator.navigationPath.isEmpty, "Navigation path should be empty upon initialization")
    }
    
    // Test navigation to dish details
    func testShowDishDetail() {
        let dishId = "53049"
        
        // Triggering navigation to dish details
        coordinator.showDishDetail(for: dishId)
        
        // Verify that the navigation path now contains one element
        XCTAssertEqual(coordinator.navigationPath.count, 1, "Navigation path should have 1 entry after navigating to a dish detail")
    }
    
    // Test back navigation
    func testGoBack() {
        let dishId = "53049"
        
        // Triggering navigation to dish details
        coordinator.showDishDetail(for: dishId)
        
        // Verify that the navigation path now contains one element
        XCTAssertEqual(coordinator.navigationPath.count, 1, "Navigation path should have 1 entry after navigating to a dish detail")
        
        // Trigger back navigation
        coordinator.goBack()
        
        // Verifying that the navigation path is now empty
        XCTAssertTrue(coordinator.navigationPath.isEmpty, "Navigation path should be empty after going back")
    }
    
    // Test multiple navigations and back
    func testMultipleNavigations() {
        let dishId1 = "53049"
        let dishId2 = "53050"
        
        // Navigate to first dish
        coordinator.showDishDetail(for: dishId1)
        XCTAssertEqual(coordinator.navigationPath.count, 1, "Navigation path should have 1 entry after first navigation")
        
        // Navigate to second dish
        coordinator.showDishDetail(for: dishId2)
        XCTAssertEqual(coordinator.navigationPath.count, 2, "Navigation path should have 2 entries after second navigation")
        
        // Going back once
        coordinator.goBack()
        XCTAssertEqual(coordinator.navigationPath.count, 1, "Navigation path should have 1 entry after going back once")
        
        // Go back again
        coordinator.goBack()
        XCTAssertTrue(coordinator.navigationPath.isEmpty, "Navigation path should be empty after going back twice")
    }
}
