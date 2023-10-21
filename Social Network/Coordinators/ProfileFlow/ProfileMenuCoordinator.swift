//
//  ProfileMenuCoordinator.swift
//  Social_Network
//
//  Created by Arthur Raff on 21.10.2023.
//

import Foundation
import UIKit

final class ProfileMenuCoordinator: Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .profileMenu }
    
    var logOutted: (() -> Void)?
    
    private var reviewer: AuthentificationReviewer?
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ProfileMenuViewController()
        
        reviewer = AuthentificationReviewerImpl()
        
        vc.reviewer = reviewer
        
        vc.delegate = self
        
        navigationController.pushViewController(vc, animated: true)
        navigationController.tabBarController?.tabBar.isHidden = true
    }
}

extension ProfileMenuCoordinator: ProfileMenuViewControllerDelegate {
    func accountRowWasTapped() {
        let coordinator = MainProfileInfoCoordinator(navigationController)
        coordinator.start()
        
        childCoordinators.append(coordinator)
    }
    
    func logoutRowWasTapped() {
        logOutted?()
        finish()
    }
}
