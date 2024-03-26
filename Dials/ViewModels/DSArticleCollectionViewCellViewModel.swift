//
//  DSArticleCollectionViewCell.swift
//  Dials
//
//  Created by Rohan Prashanth on 20/03/24.
//

import Foundation

final class DSArticleCollectionViewCellViewModel {
    let title: String
    let author: String
    let categories: [DSCategory]
    let previewImageUrl: URL?

    init(
        title: String,
        author: String,
        categories: [DSCategory],
        previewImageUrl: URL?
    ) {
        self.title = title
        self.author = author
        self.categories = categories
        self.previewImageUrl = previewImageUrl
    }
    
    public var authorText: String {
        return "By \(author)"
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = previewImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        DSImageLoader.shared.downloadImage(url, completion: completion)
    }
}
