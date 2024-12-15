//
//  Recipe.swift
//  cpsc411proj
//
//  Created by Peter Tran on 12/9/24.
//

import Foundation

struct RecipeResponse: Codable {
    let results: [Recipe]
    let offset: Int?
    let number: Int?
    let totalResults: Int?
}

struct Recipe: Identifiable, Codable {
    let id: Int
    let title: String
    let image: String
    let imageType: String?
    
    let readyInMinutes: Int?
    let servings: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, title, image, imageType, readyInMinutes, servings
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        image = try container.decode(String.self, forKey: .image)
        imageType = try container.decodeIfPresent(String.self, forKey: .imageType)
        readyInMinutes = try container.decodeIfPresent(Int.self, forKey: .readyInMinutes)
        servings = try container.decodeIfPresent(Int.self, forKey: .servings)
    }
}
