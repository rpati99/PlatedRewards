//
//  NetworkURL.swift
//  PlatedRewards
//
//  Created by Rachit Prajapati on 9/9/24.
//

import Foundation

/// Stores application's base URLs
public enum NetworkURL {
    /// Base URL for the meal db API.
    public static let base = URL(string: "https://themealdb.com/api/json/v1/1/")!
    /// Base URL for ingredient's thumbnail.
    public static let ingredient = URL(string: "https://www.themealdb.com/images/ingredients/")!
}
