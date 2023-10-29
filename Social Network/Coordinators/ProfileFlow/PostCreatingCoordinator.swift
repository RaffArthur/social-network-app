//
//  PostCreatingCoordinator.swift
//  Social_Network
//
//  Created by Arthur Raff on 28.10.2023.
//

import Foundation
import UIKit

final class PostCreatingCoordinator: Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .postCreating }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = PostCreatingViewController()
        
        vc.delegate = self
        
        navigationController.tabBarController?.tabBar.isHidden = true
        
        navigationController.show(vc, sender: nil)
    }
}

extension PostCreatingCoordinator: PostCreatingViewControllerDelegate {
    func cancelCreatingPostButtonWasTapped() {
        navigationController.popViewController(animated: true)
        
        finish()
    }
    
    func publishPostButtonWasTapped() {
        navigationController.popViewController(animated: true)
        
        finish()
    }
}
