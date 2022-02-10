//
//  FeedCoordinator.swift
//  Social_Network
//
//  Created by Arthur Raff on 13.10.2021.
//

import UIKit

@available(iOS 13.0, *)
class FeedCoordinator: Coordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .feed }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let feedVC = FeedViewController()
        
        feedVC.didSendEventClosure = { event in
            switch event {
            case .postButtonTapped:
                let coordinator = PostCoordinator(self.navigationController)
                
                coordinator.start()
            }
        }
        
        navigationController.pushViewController(feedVC, animated: true)
    }
}
