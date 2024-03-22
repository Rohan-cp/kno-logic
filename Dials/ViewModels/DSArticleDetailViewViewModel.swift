//
//  DSArticleDetailViewViewModel.swift
//  Dials
//
//  Created by Rohan Prashanth on 22/03/24.
//

import Foundation

final class DSArticleDetailViewViewModel {
    private let article: DSArticle
    
    init(article: DSArticle) {
        self.article = article
    }
    
    public var title: String {
        article.title
    }
}
