//
//  MockDishRepository.swift
//  PlatedRewards
//
//  Created by Rachit Prajapati on 9/12/24.
//

import Foundation

class MockDishRepository: DishRepositoryProtocol {
    var shouldReturnError = false
    var mockDishes: [Dish] = []
    var mockCategories: [String] = []
    var mockAreas: [String] = []
    var mockDishInfo: DishInfo?
    
    func fetchDishes(category: String?, area: String?) async throws -> [Dish] {
        if shouldReturnError {
            throw NetworkError.dataConversionFailure
        }
        return mockDishes
    }

    func fetchCategories() async throws -> [String] {
        if shouldReturnError {
            throw NetworkError.dataConversionFailure
        }
        return mockCategories
    }

    func fetchAreas() async throws -> [String] {
        if shouldReturnError {
            throw NetworkError.dataConversionFailure
        }
        return mockAreas
    }

    func fetchDishInfo(id: String) async throws -> DishInfo {
        if shouldReturnError {
            throw NetworkError.dataConversionFailure
        }
        guard let dishInfo = mockDishInfo else {
            throw NetworkError.dataConversionFailure
        }
        return dishInfo
    }
}
