//
//  FilterPickerView.swift
//  PlatedRewards
//
//  Created by Rachit Prajapati on 9/10/24.
//

import SwiftUI
 
public struct FilterPickerView: View {
    @Binding var selectedFilter: String?
    @Binding var isCategorySelected: Bool
    @ObservedObject var viewModel: DishListViewModel

    public var body: some View {
        HStack {
            if !viewModel.categories.isEmpty && !viewModel.areas.isEmpty {
                Picker("Select Filter", selection: $selectedFilter) {
                    // Categories Section
                    Section(header: Text("Categories").font(.headline).foregroundColor(.secondary)) {
                        ForEach(viewModel.categories, id: \.self) { category in
                            Text(category).tag(category as String?)
                        }
                    }
                    
                    // Areas Section
                    Section(header: Text("Areas").font(.headline).foregroundColor(.secondary)) {
                        ForEach(viewModel.areas, id: \.self) { area in
                            Text(area).tag(area as String?)
                        }
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .onChange(of: selectedFilter) { _ , newFilter in
                    if let filter = newFilter {
                        isCategorySelected = viewModel.categories.contains(filter)
                        Task {
                            await viewModel.fetchDishes(by: filter)
                        }
                    }
                }
            } else {
                Text("Loading filter options...")
            }
            Spacer()
        }.padding()
    }
}

