//
//  DishListViewModel.swift
//  PlatedRewards
//
//  Created by Rachit Prajapati on 9/10/24.
//

import SwiftUI

public final class DishListViewModel: ObservableObject {
    @Published var dishes: [Dish] = []
    @Published var categories: [String] = []
    @Published var areas: [String] = []
    @Published var state: DishListState = .loading
    
    private let dishListRepository: DishRepositoryProtocol

    // Dependency injection of the repository to facilitate testing
    init(dishListRepository: DishRepositoryProtocol = DishRepository()) {
        self.dishListRepository = dishListRepository
    }

    // Batch fetching by categories, areas, and dishes concurrently
    @MainActor
    func batchFetch(category: String = "Dessert", area: String? = nil) async {
        state = .loading
        do {
            async let fetchedCategories = dishListRepository.fetchCategories()
            async let fetchedAreas = dishListRepository.fetchAreas()
            async let fetchDishes = dishListRepository.fetchDishes(category: category, area: area)

            categories = try await fetchedCategories
            areas = try await fetchedAreas
            dishes = try await fetchDishes.sorted { $0.name.localizedCompare($1.name) == .orderedAscending }

            state = dishes.isEmpty ? .empty : .loaded(dishes)
        } catch {
            state = .error("Failed to load data: \(error.localizedDescription)")
        }
    }

    @MainActor
    func fetchDishes(by filter: String) async {
        state = .loading
        do {
            if categories.contains(filter) {
                dishes = try await dishListRepository.fetchDishes(category: filter, area: nil)
            } else if areas.contains(filter) {
                dishes = try await dishListRepository.fetchDishes(category: nil, area: filter)
            } else {
                dishes.removeAll()
            }
            state = dishes.isEmpty ? .empty : .loaded(dishes.sorted { $0.name.localizedCompare($1.name) == .orderedAscending })
           
        } catch {
            state = .error("Failed to load dishes: \(error.localizedDescription)")
        }
    }
}
