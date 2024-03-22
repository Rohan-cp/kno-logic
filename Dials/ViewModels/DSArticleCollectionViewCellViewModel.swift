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
    let previewImageUrl: URL?

    init(
        title: String,
        author: String,
        previewImageUrl: URL?
    ) {
        self.title = title
        self.author = author
        self.previewImageUrl = previewImageUrl
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        // TODO: abstract to image manager
        guard let url = previewImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
