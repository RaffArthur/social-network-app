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
    let profileBarItem: UITabBarItem = {
        let profileBarItem = UITabBarItem()
        profileBarItem.image = UIImage(systemName: "person.fill")
        profileBarItem.title = "Profile"

        return profileBarItem
    }()
    let feedBarItem: UITabBarItem = {
        let feedBarItem = UITabBarItem()
        feedBarItem.image = UIImage(systemName: "house.fill")
        feedBarItem.title = "Feed"

        return feedBarItem
    }()
    
    // MARK: - View Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
                
        let profileViewController = UINavigationController(rootViewController: ProfileViewController())
        let feedVievController = UINavigationController(rootViewController: FeedViewController())
        let tabBarList = [profileViewController, feedVievController]
        
        profileViewController.tabBarItem = profileBarItem
        feedVievController.tabBarItem = feedBarItem
        
        viewControllers = tabBarList
    }
}


