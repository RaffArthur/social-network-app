//
//  FeedCoordinator.swift
//  Social_Network
//
//  Created by Arthur Raff on 09.02.2021.
//

import UIKit

@available(iOS 13.0, *)
class FeedCoordinator: Coordinator{
    
    // MARK: - Properties
    var navigationController: UINavigationController
    
    // MARK: - Coordinator Initialization
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Launching the FeedCoordinator
    func start() {
        let vc = FeedViewController()
        
        vc.coordinator = self
        
        push(vc: vc, animated: false)
    }
    
    // MARK: - Launching the PostCoordinator
    func showPost() {
        let vc = PostViewController()
        
        vc.coordinator = self
        
        push(vc: vc, animated: true)
    }
}
