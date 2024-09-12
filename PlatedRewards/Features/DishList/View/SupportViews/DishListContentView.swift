//
//  DishListContentView.swift
//  PlatedRewards
//
//  Created by Rachit Prajapati on 9/10/24.
//

import SwiftUI

public struct DishListContentView: View {
    let dishes: [Dish]
    @EnvironmentObject var coordinator: AppCoordinator  // Access the coordinator
    
    public var body: some View {
        List {
            ForEach(dishes, id: \.id) { dish in
                // Pass the dish ID to DishInfoView via NavigationLink
                Button(action: {
                    coordinator.showDishDetail(for: dish.id)  // Navigate to dish details
                }) {
                    DishRowView(dish: dish)
                }
            }
        }
        .scrollContentBackground(.hidden)
        .listStyle(.plain)
    }
}
