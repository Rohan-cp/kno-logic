//
//  DSSavedViewController.swift
//  Dials
//
//  Created by Rohan Prashanth on 19/03/24.
//

import UIKit

// Controller to show saved articles
final class DSSavedViewController: UIViewController {
    
    private let articleListView = ArticleListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Saved"
        view.addSubview(articleListView)
        NSLayoutConstraint.activate([
            articleListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            articleListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            articleListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            articleListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}
