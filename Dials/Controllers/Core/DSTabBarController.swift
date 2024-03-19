//
//  ViewController.swift
//  Dials
//
//  Created by Rohan Prashanth on 19/03/24.
//

import UIKit

final class DSTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }

    private func setupTabs() {
        let dailyVC = DSDailyViewController()
        let savedVC = DSSavedViewController()
        
        dailyVC.navigationItem.largeTitleDisplayMode = .automatic
        savedVC.navigationItem.largeTitleDisplayMode = .automatic
       
        let nav1 = UINavigationController(rootViewController: dailyVC)
        let nav2 = UINavigationController(rootViewController: savedVC)
        
        nav1.tabBarItem = UITabBarItem(title: "Daily", image: UIImage(systemName: "newspaper"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Saved", image: UIImage(systemName: "bookmark"), tag: 1)

        for nav in [nav1, nav2] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers([nav1, nav2], animated: true)
    }
}

