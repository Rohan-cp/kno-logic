//
//  DSGetArticlesResponse.swift
//  Dials
//
//  Created by Rohan Prashanth on 19/03/24.
//

import Foundation

struct DSGetArticlesResponse: Codable {
    let articles: [DSArticle]
    let count: Int
}
