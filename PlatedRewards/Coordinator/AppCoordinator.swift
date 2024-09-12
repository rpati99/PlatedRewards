//
//  AppCoordinator.swift
//  PlatedRewards
//
//  Created by Rachit Prajapati on 9/11/24.
//

import SwiftUI

public final class AppCoordinator: ObservableObject, AppCoordinatorProtocol {
    @Published public var navigationPath = NavigationPath()
    
    public func showDishDetail(for mealId: String) {
        navigationPath.append(mealId)
    }

    public func goBack() {
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
    }
}
