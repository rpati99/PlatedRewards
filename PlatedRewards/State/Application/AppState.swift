//
//  AppState.swift
//  PlatedRewards
//
//  Created by Rachit Prajapati on 9/11/24.
//

import Foundation

// Enum to represent the different states of the dish list UI
public enum DishListState: Equatable {
    case loading
    case loaded([Dish])
    case error(String)
    case empty

    // Manually implement Equatable
    public static func == (lhs: DishListState, rhs: DishListState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.empty, .empty):
            return true
        case (.loaded(let lhsDishes), .loaded(let rhsDishes)):
            return lhsDishes == rhsDishes
        case (.error(let lhsError), .error(let rhsError)):
            return lhsError == rhsError
        default:
            return false
        }
    }
}


// Enum to represent the states of the dish info UI
public enum DishInfoState: Equatable {
    case loading
    case loaded(DishInfo)
    case error(String)

    // Implement Equatable for `DishInfoState`
    public static func == (lhs: DishInfoState, rhs: DishInfoState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.loaded(let lhsDishInfo), .loaded(let rhsDishInfo)):
            return lhsDishInfo == rhsDishInfo
        case (.error(let lhsError), .error(let rhsError)):
            return lhsError == rhsError
        default:
            return false
        }
    }
}
