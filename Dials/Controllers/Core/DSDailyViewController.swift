//
//  DSDailyViewController.swift
//  Dials
//
//  Created by Rohan Prashanth on 19/03/24.
//

import UIKit

// Controller to show home page (carousel with daily digest articles)
final class DSDailyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Daily"
        
        
        let request = DSRequest(endpoint: .articles)
        print(request.url)
        
        DSService.shared.execute(request, expecting: DSArticle.self) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}
