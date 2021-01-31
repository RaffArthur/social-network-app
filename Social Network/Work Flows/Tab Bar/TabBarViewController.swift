//
//  TabBarViewController.swift
//  Navigation
//
//  Created by Arthur Raff on 12.10.2020.
//

import UIKit

@available(iOS 13.0, *)
class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - Properties
    private let profileBarItem: UITabBarItem = {
        let profileBarItem = UITabBarItem()
        profileBarItem.image = UIImage(systemName: "person.fill")
        profileBarItem.title = "Profile"

        return profileBarItem
    }()
    private let feedBarItem: UITabBarItem = {
        let feedBarItem = UITabBarItem()
        feedBarItem.image = UIImage(systemName: "house.fill")
        feedBarItem.title = "Feed"

        return feedBarItem
    }()
    private let feedVC = FeedViewController()
    private let profileVC = ProfileViewController()
    private let postPresenter = PostPresenter()

    // MARK: - View Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
                
        let profileNC = UINavigationController(rootViewController: profileVC)
        let feedNC = UINavigationController(rootViewController: feedVC)
        let tabBarList = [profileNC, feedNC]
                
        profileVC.tabBarItem = profileBarItem
        feedVC.tabBarItem = feedBarItem
        
        viewControllers = tabBarList
        
        feedVC.output = postPresenter
    }
}


