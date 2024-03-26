//
//  DSDailyViewController.swift
//  Dials
//
//  Created by Rohan Prashanth on 19/03/24.
//

import UIKit

// Controller to show home page (carousel with daily digest articles)
final class DSDailyViewController: UIViewController, DSArticleCarouselViewDelegate {
    
    private let articleCarouselView = DSArticleCarouselView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0x2E / 255.0, green: 0x2F / 255.0, blue: 0x41 / 255.0, alpha: 1.0)
        title = "Daily"
        setUpView()
    }
    
    private func setUpView() {
        articleCarouselView.delegate = self
        view.addSubview(articleCarouselView)
        NSLayoutConstraint.activate([
            articleCarouselView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            articleCarouselView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            articleCarouselView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            articleCarouselView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    // MARK: - DSArticleListViewDelegate
    
    func dsArticleCarouselView(_ articleCarouselView: DSArticleCarouselView, didSelectArticle article: DSArticle) {
       // Open detail controller for that article
        let viewModel = DSArticleDetailViewViewModel(article: article)
        let detailVC = DSArticleDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }


}
