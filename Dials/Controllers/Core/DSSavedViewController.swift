//
//  DSSavedViewController.swift
//  Dials
//
//  Created by Rohan Prashanth on 19/03/24.
//

import UIKit

// Controller to show saved articles
final class DSSavedViewController: UIViewController, DSArticleListViewDelegate {
    
    private let articleListView = DSArticleListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Saved"
        setUpView()
    }
    
    private func setUpView() {
        articleListView.delegate = self
        view.addSubview(articleListView)
        NSLayoutConstraint.activate([
            articleListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            articleListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            articleListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            articleListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    // MARK: - DSArticleListViewDelegate
    
    func dsArticleListView(_ articleListView: DSArticleListView, didSelectArticle article: DSArticle) {
       // Open detail controller for that article
        let viewModel = DSArticleDetailViewViewModel(article: article)
        let detailVC = DSArticleDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
