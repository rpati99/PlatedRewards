//
//  DishNetworkService.swift
//  PlatedRewards
//
//  Created by Rachit Prajapati on 9/9/24.
//

import Foundation

protocol DishNetworkServiceProtocol {
    func fetchDishes(category: String?, area: String?) async throws -> [Dish]
    func fetchCategories() async throws -> [String]
    func fetchAreas() async throws -> [String]
    func fetchDishInfo(id: String) async throws -> DishInfo
}

class DishNetworkService: BaseNetworkService<DishRouter>, DishNetworkServiceProtocol {
    
    // Fetch dishes by optional category and area (category or area can be nil)
    func fetchDishes(category: String?, area: String?) async throws -> [Dish] {
        let result = await request(DishList.self, router: .fetchDishes(category: category, area: area))
        switch result {
        case .success(let wrapper):
            return wrapper.dishes
        case .failure(let error):
            error.logError()
            throw error
        }
    }
    
    // Fetch available categories
    func fetchCategories() async throws -> [String] {
        let result = await request(CategoryList.self, router: .fetchCategories)
        switch result {
        case .success(let wrapper):
            return wrapper.categories
        case .failure(let error):
            error.logError()
            throw error
        }
    }
    
    // Fetch available areas (countries)
    func fetchAreas() async throws -> [String] {
        let result = await request(AreaList.self, router: .fetchAreas)
        switch result {
        case .success(let wrapper):
            return wrapper.areas
        case .failure(let error):
            error.logError()
            throw error
        }
    }
    
    // Fetch details by ID
    func fetchDishInfo(id: String) async throws -> DishInfo {
        let result = await request(DishInfoCoding.self, router: .fetchDishInfo(id: id))
        switch result {
        case .success(let wrapper):
            guard let dish = wrapper.dishes.first else {
                let error = NetworkError.dataConversionFailure
                error.logError()  // Log the error
                throw NetworkError.dataConversionFailure
            }
            return dish
        case .failure(let error):
            error.logError()
            throw error
        }
    }
}


