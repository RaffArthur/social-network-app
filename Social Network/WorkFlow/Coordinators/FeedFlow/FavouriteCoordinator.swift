//
//  FavouriteCoordinator.swift
//  Social_Network
//
//  Created by Arthur Raff on 13.10.2021.
//

import UIKit

@available(iOS 13.0, *)
class FavouriteCoordinator: Coordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .favourite }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let favouriteVC = FeedViewController()
        
        favouriteVC.didSendEventClosure = { event in
            switch event {
            case .postButtonTapped:
                let coordinator = PostCoordinator(self.navigationController)
                
                coordinator.start()
            }
        }
        
        navigationController.pushViewController(favouriteVC, animated: true)
    }
}