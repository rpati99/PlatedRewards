//
//  ListCoding.swift
//  PlatedRewards
//
//  Created by Rachit Prajapati on 9/11/24.
//

import Foundation

public struct CategoryList: Decodable {
    public let categories: [String]
    
    private enum CodingKeys: String, CodingKey {
        case categories = "meals"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let categoryList = try container.decodeIfPresent([[String: String]].self, forKey: .categories) ?? []
        self.categories = categoryList.compactMap { $0["strCategory"] }
    }
}


public struct AreaList: Decodable {
    public let areas: [String]
    
    private enum CodingKeys: String, CodingKey {
        case areas = "meals"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let areaList = try container.decodeIfPresent([[String: String]].self, forKey: .areas) ?? []
        self.areas = areaList.compactMap { $0["strArea"] }
    }
}
