//
//  FavouriteCoordinator.swift
//  Social_Network
//
//  Created by Arthur Raff on 13.10.2021.
//

import UIKit

final class FavouriteCoordinator: Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .favourite }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = FavouriteViewController()
        
        navigationController.pushViewController(vc, animated: true)
    }
}
