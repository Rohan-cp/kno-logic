//
//  ArticlesListViewModel.swift
//  Dials
//
//  Created by Rohan Prashanth on 19/03/24.
//

import UIKit

protocol DSArticlesListViewViewModelDelegate: AnyObject {
    func didLoadInitialArticles()
    func didSelectArticle(_ article: DSArticle)
}

final class DSArticlesListViewViewModel: NSObject {
    
    public weak var delegate: DSArticlesListViewViewModelDelegate?
    
    private var articles: [DSArticle] = [] {
        didSet {
            for article in articles {
                let viewModel = DSArticleCollectionViewCellViewModel(
                    title: article.title,
                    author: article.author,
                    categories: article.categories,
                    previewImageUrl: URL(string: article.previewImageUrl)
                )
                cellViewModels.append(viewModel)
            }
        }
    }
    
    private var cellViewModels: [DSArticleCollectionViewCellViewModel] = []
    
    public func fetchSavedArticles() {
        DSService.shared.execute(.articlesRequests, expecting: DSGetArticlesResponse.self) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let response = responseModel
                self?.articles = response.articles
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialArticles()
                }
                print(String(describing: response))
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    

}

extension DSArticlesListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DSArticleCollectionViewCell.cellIdentifier, for: indexPath
        ) as? DSArticleCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        
        let viewModel = cellViewModels[indexPath.row]
        cell.configure(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = bounds.width - 30
        return CGSize(width: width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        delegate?.didSelectArticle(article)
    }
}
