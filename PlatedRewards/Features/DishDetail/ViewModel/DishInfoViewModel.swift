//
//  DishInfoViewModel.swift
//  PlatedRewards
//
//  Created by Rachit Prajapati on 9/11/24.
//
import SwiftUI

public final class DishInfoViewModel: ObservableObject {
    @Published var state: DishInfoState = .loading
    @Published var dishInfo: DishInfo?

    private let dishRepository: DishRepositoryProtocol

    init(mealRepository: DishRepositoryProtocol = DishRepository()) {
        self.dishRepository = mealRepository
    }

    // Fetch meal details by dish ID
    @MainActor
    func fetchDishInfo(dishId: String) async {
        state = .loading
        do {
            self.dishInfo = try await dishRepository.fetchDishInfo(id: dishId)
            if let dish = dishInfo {
                state = .loaded(dish)
            } 
        } catch {
            state = .error("Failed to load meal details: \(error.localizedDescription)")
        }
    }
}
