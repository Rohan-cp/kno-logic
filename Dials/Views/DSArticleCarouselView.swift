//
//  DSArticleCarouselView.swift
//  Dials
//
//  Created by Rohan Prashanth on 22/03/24.
//

import UIKit

protocol DSArticleCarouselViewDelegate: AnyObject {
    func dsArticleCarouselView(
        _ articleCarouselView: DSArticleCarouselView,
        didSelectArticle article: DSArticle
    )
}

final class DSArticleCarouselView: UIView, DSArticlesListViewViewModelDelegate {
    
    public weak var delegate: DSArticleCarouselViewDelegate?
    
    private let viewModel = DSArticleCarouselViewViewModel()

    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let carouselView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let carouselView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        carouselView.isHidden = true
        carouselView.alpha = 0
        carouselView.translatesAutoresizingMaskIntoConstraints = false
        carouselView.register(DSArticleCarouselViewCell.self, forCellWithReuseIdentifier: DSArticleCarouselViewCell.cellIdentifier)
        return carouselView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(carouselView, spinner)
        
        addConstraints()
        
        spinner.startAnimating()
        viewModel.delegate = self
        viewModel.fetchDailyDigestArticles()
        setUpCarouselView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            carouselView.topAnchor.constraint(equalTo: topAnchor),
            carouselView.leftAnchor.constraint(equalTo: leftAnchor),
            carouselView.rightAnchor.constraint(equalTo: rightAnchor),
            carouselView.bottomAnchor.constraint(equalTo: bottomAnchor),

        ])
    }
    
    private func setUpCarouselView() {
        carouselView.dataSource = viewModel
        carouselView.delegate = viewModel
    }
}

extension DSArticleCarouselView: DSArticleCarouselViewViewModelDelegate {
    func didSelectArticle(_ article: DSArticle) {
        delegate?.dsArticleCarouselView(self, didSelectArticle: article)
    }
    
    func didLoadInitialArticles() {
        spinner.stopAnimating()
        carouselView.reloadData() // initial fetch
        
        carouselView.isHidden = false
        
        UIView.animate(withDuration: 0.4) {
            self.carouselView.alpha = 1
        }
    }
}
