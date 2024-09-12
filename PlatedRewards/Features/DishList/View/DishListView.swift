//
//  DishListView.swift
//  PlatedRewards
//
//  Created by Rachit Prajapati on 9/8/24.
//

import SwiftUI

// Main screen
public struct DishListView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var viewModel: DishListViewModel
    @EnvironmentObject var coordinator: AppCoordinator
    
    @State private var selectedFilter: String? = "Dessert"
    @State private var isCategorySelected: Bool = true
    @State private var hasLoadedData: Bool = false
    
    init(viewModel: DishListViewModel = DishListViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            VStack {
                FilterPickerView(selectedFilter: $selectedFilter, isCategorySelected: $isCategorySelected, viewModel: viewModel)
                
                // State driven UI loading
                switch viewModel.state {
                    case .loading:
                        ProgressView("Loading dishes...")
                    case .loaded(let dishes):
                        DishListContentView(dishes: dishes)
                            .navigationTitle(navigationTitle)
                    case .error(let errorMessage):
                        Text(errorMessage)
                            .foregroundColor(.red)
                    case .empty:
                        Text("No dishes found")
                            .foregroundColor(.gray)
                }
            }
            .onAppear {
                if !hasLoadedData {
                    Task {
                        await viewModel.batchFetch()
                        hasLoadedData = true
                    }
                }
            }
            .navigationDestination(for: String.self) { dishId in
                // Navigation to Dish information screen with the selected dish identifier
                DishInfoView(dishId: dishId)
            }
        }
        .tint(colorScheme == .dark ? .white : .black) // Dark mode support
    }
    
    // Curating navigation title for user convenience
    var navigationTitle: String {
        if selectedFilter == nil {
            return "Dishes"
        } else if isCategorySelected {
            return "Fetch from category"
        } else {
            return "Fetch from area"
        }
    }
}



