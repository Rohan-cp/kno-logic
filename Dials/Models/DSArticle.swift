//
//  DSArticle.swift
//  Dials
//
//  Created by Rohan Prashanth on 19/03/24.
//

import Foundation

struct DSArticle: Codable {
    let title: String
    let author: String
    let category: DSCategory
    let date: String
    let description: String
    let link: String
    let imageUrl: String
}

