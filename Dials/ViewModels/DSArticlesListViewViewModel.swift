//
//  ArticlesListViewModel.swift
//  Dials
//
//  Created by Rohan Prashanth on 19/03/24.
//

import UIKit

final class DSArticlesDetailViewViewModel: NSObject {
    func fetchSavedArticles() {
        DSService.shared.execute(.articlesRequests, expecting: DSGetArticlesResponse.self) { result in
            switch result {
            case .success(let model):
                print(String(describing: model))
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

extension DSArticlesDetailViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DSArticleCollectionViewCell.cellIdentifier, for: indexPath
        ) as? DSArticleCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        let viewModel = DSArticleCollectionViewCellViewModel(title: "Dormio: Interfacing with dreams", author: "MIT Media Labs", imageUrl: nil)
        cell.configure(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = bounds.width - 30
        return CGSize(width: width, height: 100)
    }
}
