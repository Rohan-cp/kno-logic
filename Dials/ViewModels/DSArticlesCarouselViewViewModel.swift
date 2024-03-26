//
//  DSArticlesCarouselViewViewModel.swift
//  Dials
//
//  Created by Rohan Prashanth on 22/03/24.
//

import UIKit

protocol DSArticleCarouselViewViewModelDelegate: AnyObject {
    func didLoadInitialArticles()
    func didSelectArticle(_ article: DSArticle)
}

final class DSArticleCarouselViewViewModel: NSObject {
    
    public weak var delegate: DSArticleCarouselViewViewModelDelegate?
    
    private var articles: [DSArticle] = [] {
        didSet {
            for article in articles {
                let viewModel = DSArticleCollectionViewCellViewModel(
                    title: article.title,
                    author: article.author,
                    categories: article.categories,
                    previewImageUrl: URL(string: article.previewImageUrl)
                )
                carouselCellViewModels.append(viewModel)
            }
        }
    }
    
    private var carouselCellViewModels: [DSArticleCollectionViewCellViewModel] = []
    
    public func fetchDailyDigestArticles() {
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

extension DSArticleCarouselViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carouselCellViewModels.count
    }
    
    func collectionView(_ carouselView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = carouselView.dequeueReusableCell(withReuseIdentifier: DSArticleCarouselViewCell.cellIdentifier, for: indexPath
        ) as? DSArticleCarouselViewCell else {
            fatalError("Unsupported cell")
        }
        
        let viewModel = carouselCellViewModels[indexPath.row]
        cell.configure(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = bounds.width - 50
        let height = bounds.height - 350
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        delegate?.didSelectArticle(article)
    }
}
