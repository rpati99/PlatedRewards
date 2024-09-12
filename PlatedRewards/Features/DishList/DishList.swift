//
//  DishList.swift
//  PlatedRewards
//
//  Created by Rachit Prajapati on 9/11/24.
//

import Foundation

public struct DishList: Decodable {
    public let dishes: [Dish]
    
    private enum CodingKeys: String, CodingKey {
        case meals
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.dishes = try container.decodeIfPresent([Dish].self, forKey: .meals) ?? []
    }
}
