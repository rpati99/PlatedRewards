//
//  Dish.swift
//  PlatedRewards
//
//  Created by Rachit Prajapati on 9/9/24.
//

import Foundation

public struct Dish: Decodable, Identifiable, Equatable {
    public let id: String
    public let name: String
    public let thumbnailURL: URL?
    
    private enum CodingKeys: String, CodingKey {
        case idMeal
        case strMeal
        case strMealThumb
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = (try container.decodeIfPresent(String.self, forKey: .idMeal) ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        self.name = (try container.decodeIfPresent(String.self, forKey: .strMeal) ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let thumbnail = (try container.decodeIfPresent(String.self, forKey: .strMealThumb) ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
               
               // Validating the URL to ensure it is valid (e.g., starts with "http" or "https")
               if thumbnail.hasPrefix("http"), let url = URL(string: "\(thumbnail)/preview") {
                   self.thumbnailURL = url
               } else {
                   self.thumbnailURL = nil
               }
       
    }
    
    public init(from meal: DishInfo) {
        self.id = meal.id
        self.name = meal.name
        self.thumbnailURL = meal.thumbnailURL
    }

    // Added Equatable conformance
    public static func ==(lhs: Dish, rhs: Dish) -> Bool {
        return lhs.id == rhs.id &&
               lhs.name == rhs.name &&
               lhs.thumbnailURL == rhs.thumbnailURL
    }
}



