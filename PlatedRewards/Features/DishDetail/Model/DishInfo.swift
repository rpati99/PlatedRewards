//
//  DishInfo.swift
//  PlatedRewards
//
//  Created by Rachit Prajapati on 9/9/24.
//

import Foundation

public struct DishInfo: Decodable, Equatable, Identifiable {
    public let id: String
    public let name: String
    public let thumbnailURL: URL?
    public let instructions: [String]
    public let youtubeURL: URL?
    public let sourceURL: URL?
    
    private enum CodingKeys: CodingKey {
        case idMeal
        case strMeal
        case strMealThumb
        case strInstructions
        case strYoutube
        case strSource
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container
            .decodeIfPresent(String.self, forKey: .idMeal)?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        self.name = try container
            .decodeIfPresent(String.self, forKey: .strMeal)?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        let thumbnail = try container
            .decodeIfPresent(String.self, forKey: .strMealThumb)?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        self.thumbnailURL = URL(string: thumbnail)
        
        
        let instructions = try container
            .decodeIfPresent(String.self, forKey: .strInstructions)?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        self.instructions = instructions.split(separator: "\r\n").map { String($0) }
        
        let youtube = try container
            .decodeIfPresent(String.self, forKey: .strYoutube)?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        self.youtubeURL = URL(string: youtube)
        
        let source = try container
            .decodeIfPresent(String.self, forKey: .strSource)?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        self.sourceURL = URL(string: source)
    }
}



