//
//  AppCoordinator.swift
//  Social_Network
//
//  Created by Arthur Raff on 09.02.2021.
//

import UIKit

@available(iOS 13.0, *)
final class AppCoordinator: TabBarCoordinator {
    
    var childCoordinators = [Coordinator]()
    private(set) var tabBarController: UITabBarController
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    func start() {
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
        
        let profileNC = UINavigationController()
        let feedNC = UINavigationController()
        
        feedNC.tabBarItem = feedBarItem
        profileNC.tabBarItem = profileBarItem
        
        let profileCoordinator = ProfileCoordinator(navigationController: profileNC)
        let feedCoordinator = FeedCoordinator(navigationController: feedNC)
        
        childCoordinators = [feedCoordinator, profileCoordinator]
        
        profileCoordinator.start()
        feedCoordinator.start()
   
        let controllers = [profileNC, feedNC]
      
        tabBarController.viewControllers = controllers
    }
}
