//
//  NavigationCoordinator.swift
//  Social_Network
//
//  Created by Arthur Raff on 30.07.2022.
//

import UIKit

final class MapCoordinator: Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .map }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MapViewController()
        
        navigationController.pushViewController(vc, animated: true)
    }
}
