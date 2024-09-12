//
//  DishInfoCoding.swift
//  PlatedRewards
//
//  Created by Rachit Prajapati on 9/11/24.
//

import Foundation

public struct DishInfoCoding: Decodable, Equatable {
    public let dishes: [DishInfo]
    
    enum CodingKeys: CodingKey {
        case meals
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.dishes = try container.decodeIfPresent([DishInfo].self, forKey: .meals) ?? []
    }
}

