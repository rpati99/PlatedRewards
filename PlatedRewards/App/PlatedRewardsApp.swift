//
//  PlatedRewardsApp.swift
//  PlatedRewards
//
//  Created by Rachit Prajapati on 9/8/24.
//

import SwiftUI

@main
struct PlatedRewardsApp: App {
    @StateObject private var coordinator = AppCoordinator()

    
    var body: some Scene {
        WindowGroup {
            DishListView(viewModel: DishListViewModel())
                  .environmentObject(coordinator)
        }
    }
}
