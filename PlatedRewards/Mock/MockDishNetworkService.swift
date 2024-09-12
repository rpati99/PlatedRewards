//
//  MockDishNetworkService.swift
//  PlatedRewards
//
//  Created by Rachit Prajapati on 9/9/24.
//
import Foundation

class MockDishNetworkService: DishNetworkServiceProtocol {
    
    var mockDishes: [Dish] = []
    var mockCategories: [String] = []
    var mockAreas: [String] = []
    var mockDishInfo: DishInfo?
    var shouldReturnError = false
    
    // Mock fetchDishes method
    func fetchDishes(category: String?, area: String?) async throws -> [Dish] {
        if shouldReturnError {
            throw NetworkError.requestFailed(statusCode: 500)
        }
        return mockDishes
    }
    
    // Mock fetchCategories method
    func fetchCategories() async throws -> [String] {
        if shouldReturnError {
            throw NetworkError.requestFailed(statusCode: 500)
        }
        return mockCategories
    }
    
    // Mock fetchAreas method
    func fetchAreas() async throws -> [String] {
        if shouldReturnError {
            throw NetworkError.requestFailed(statusCode: 500)
        }
        return mockAreas
    }
    
    // Mock fetchDishInfo method
    func fetchDishInfo(id: String) async throws -> DishInfo {
        if shouldReturnError {
            throw NetworkError.dataConversionFailure
        }
        guard let mockDishInfo = mockDishInfo else {
            throw NetworkError.dataConversionFailure
        }
        return mockDishInfo
    }
}
