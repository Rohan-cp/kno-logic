//
//  DSGetArticlesResponse.swift
//  Dials
//
//  Created by Rohan Prashanth on 19/03/24.
//

import Foundation

struct DSGetArticlesResponse: Codable {
    let articles: [DSArticle]
        
    // If the JSON directly starts with an array, use this initializer to decode.
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        articles = try container.decode([DSArticle].self)
    }
}
