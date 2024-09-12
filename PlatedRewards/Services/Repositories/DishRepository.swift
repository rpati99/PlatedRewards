//
//  DishRepository.swift
//  PlatedRewards
//
//  Created by Rachit Prajapati on 9/9/24.
//

import Foundation

public protocol DishRepositoryProtocol {
    func fetchDishes(category: String?, area: String?) async throws -> [Dish]
    func fetchCategories() async throws -> [String]
    func fetchAreas() async throws -> [String]
    func fetchDishInfo(id: String) async throws -> DishInfo
}

public final class DishRepository: DishRepositoryProtocol {
    private let networkService: DishNetworkServiceProtocol
    
    
    // Initialize the repository with a network service, using dependency injection
    init(networkService: DishNetworkServiceProtocol = DishNetworkService()) {
        self.networkService = networkService
    }
    
    // Fetch dishes by optional category and area
    public func fetchDishes(category: String? = nil, area: String? = nil) async throws -> [Dish] {
        do {
            return try await networkService.fetchDishes(category: category, area: area)
        } catch {
            LoggerHelper.generalLogger.error("Failed to fetch dishes: \(error.localizedDescription, privacy: .public)")
            throw error
        }
    }
    
    // Fetch available categories
    public func fetchCategories() async throws -> [String] {
        do {
            return try await networkService.fetchCategories()
        } catch {
            LoggerHelper.generalLogger.error("Failed to fetch categories: \(error.localizedDescription, privacy: .public)")
            throw error
        }
    }
    
    // Fetch available areas (countries)
    public func fetchAreas() async throws -> [String] {
        do {
            return try await networkService.fetchAreas()
        } catch {
            LoggerHelper.generalLogger.error("Failed to fetch areas: \(error.localizedDescription, privacy: .public)")
            throw error
        }
    }
    
    // Fetch dish details by ID
    public func fetchDishInfo(id: String) async throws -> DishInfo {
        do {
            return try await networkService.fetchDishInfo(id: id)
        }  catch {
            LoggerHelper.generalLogger.error("Failed to fetch dish info: \(error.localizedDescription, privacy: .public)")
            throw error
        }
    }
}
