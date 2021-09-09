//
//  FeedCoordinator.swift
//  Social_Network
//
//  Created by Arthur Raff on 09.02.2021.
//

import UIKit

@available(iOS 13.0, *)
class FeedCoordinator: Coordinator{
    private(set) var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = FeedViewController()
        
        vc.coordinator = self
        
        push(vc: vc, animated: false)
    }
    
    func showPost() {
        let vc = PostViewController()
        
        vc.coordinator = self
        
        push(vc: vc, animated: true)
    }
}
