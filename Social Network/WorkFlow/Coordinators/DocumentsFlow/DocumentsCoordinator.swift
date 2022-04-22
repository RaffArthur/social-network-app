//
//  DocumentsCoordinator.swift
//  Social_Network
//
//  Created by Arthur Raff on 22.04.2022.
//

import UIKit

class DocumentsCoordinator: Coordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .documents }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = DocumentsViewController()
        
        navigationController.pushViewController(vc, animated: true)
    }
}
