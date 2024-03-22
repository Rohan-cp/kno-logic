//
//  DSArticleDetailViewController.swift
//  Dials
//
//  Created by Rohan Prashanth on 22/03/24.
//

import UIKit

// Controller to show information about single character
class DSArticleDetailViewController: UIViewController {
    private let viewModel: DSArticleDetailViewViewModel
    
    init(viewModel: DSArticleDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }
}
