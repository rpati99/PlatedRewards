//
//  AppCoordinatorProtocol.swift
//  PlatedRewards
//
//  Created by Rachit Prajapati on 9/11/24.
//

import SwiftUI

public protocol AppCoordinatorProtocol: ObservableObject {
    var navigationPath: NavigationPath { get set }
    func showDishDetail(for mealId: String)
    func goBack()
}
