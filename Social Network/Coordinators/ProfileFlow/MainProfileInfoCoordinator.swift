//
//  MainProfileInfoCoordinator.swift
//  Social_Network
//
//  Created by Arthur Raff on 15.10.2023.
//

import Foundation
import UIKit

final class MainProfileInfoCoordinator: Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .mainProfileInfo }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MainProfileInfoViewController()
        
        vc.delegate = self
        
        navigationController.show(vc, sender: nil)
        navigationController.tabBarController?.tabBar.isHidden = true
    }
}

extension MainProfileInfoCoordinator: MainProfileInfoViewControllerDelegate {
    func cancelProfileInfoButtonWasTapped() {
        navigationController.popViewController(animated: true)
        
        finish()
    }
    
    func saveProfileInfoButtonWasTapped() {
        navigationController.popViewController(animated: true)
        
        finish()
    }
}
