//
//  DishInfo.swift
//  PlatedRewards
//
//  Created by Rachit Prajapati on 9/9/24.
//

import Foundation

public struct DishInfo: Decodable, Identifiable, Equatable {
    public let id: String
    public let name: String
    public let thumbnailURL: URL?
    public let instructions: [String]
    public let youtubeURL: URL?
    public let sourceURL: URL?
    public let ingredients: [Ingredient]

    enum TopLevelKeys: String, CodingKey {
        case mealID = "idMeal"
        case mealName = "strMeal"
        case mealThumbnail = "strMealThumb"
        case mealInstructions = "strInstructions"
        case youtubeLink = "strYoutube"
        case sourceLink = "strSource"
    }
    
    enum DynamicKeys: String {
        case ingredientPrefix = "strIngredient"
        case measurePrefix = "strMeasure"
    }

    struct IngredientKey: CodingKey {
        let key: String
        
        var stringValue: String { return key }
        var intValue: Int? { return nil }
        
        init?(stringValue: String) {
            self.key = stringValue
        }
        
        init?(intValue: Int) { return nil }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TopLevelKeys.self)
        
        // Extracting static fields
        self.id = (try container.decodeIfPresent(String.self, forKey: .mealID) ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        self.name = (try container.decodeIfPresent(String.self, forKey: .mealName) ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        
        let thumbnailString = (try container.decodeIfPresent(String.self, forKey: .mealThumbnail) ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        self.thumbnailURL = URL(string: thumbnailString)
        
        let instructionsString = (try container.decodeIfPresent(String.self, forKey: .mealInstructions) ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        self.instructions = instructionsString.split(separator: "\n").map { String($0) }
        
        let youtubeString = (try container.decodeIfPresent(String.self, forKey: .youtubeLink) ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        self.youtubeURL = URL(string: youtubeString)
        
        let sourceString = (try container.decodeIfPresent(String.self, forKey: .sourceLink) ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        self.sourceURL = URL(string: sourceString)
        
        // Parse ingredients and measurements dynamically
        let dynamicContainer = try decoder.container(keyedBy: IngredientKey.self)
        self.ingredients = DishInfo.parseIngredients(from: dynamicContainer)
    }
    
    // Function to parse ingredients and measures dynamically
    static func parseIngredients(from container: KeyedDecodingContainer<IngredientKey>) -> [Ingredient] {
        var ingredientList = [Ingredient]()
        
        // Iterate over dynamic keys to extract ingredients and measures
        for index in 1...20 {
            let ingredientKey = IngredientKey(stringValue: "\(DynamicKeys.ingredientPrefix.rawValue)\(index)")!
            let measureKey = IngredientKey(stringValue: "\(DynamicKeys.measurePrefix.rawValue)\(index)")!
            
            if let ingredientName = try? container.decodeIfPresent(String.self, forKey: ingredientKey),
               let measure = try? container.decodeIfPresent(String.self, forKey: measureKey),
               !ingredientName.isEmpty {
                
                let cleanedIngredient = ingredientName.trimmingCharacters(in: .whitespacesAndNewlines)
                let cleanedMeasure = measure.trimmingCharacters(in: .whitespacesAndNewlines)
                let ingredient = Ingredient(name: cleanedIngredient, quantity: cleanedMeasure)
                
                ingredientList.append(ingredient)
            }
        }
        
        return ingredientList
    }
}

public struct Ingredient: Decodable, Hashable, Comparable {
    public let name: String
    public let quantity: String
    
    public static func < (lhs: Ingredient, rhs: Ingredient) -> Bool {
        lhs.name < rhs.name
    }
}
