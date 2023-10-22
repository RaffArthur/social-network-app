//
//  ProfileDetailedInfoCoordinator.swift
//  Social_Network
//
//  Created by Arthur Raff on 22.10.2023.
//

import Foundation
import UIKit

final class ProfileDetailedInfoCoodinator: Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .profileDetailedInfo }
        
    private var reviewer: AuthentificationReviewer?
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ProfileDetailedInfoViewController()
        
        navigationController.tabBarController?.tabBar.isHidden = true
        
        navigationController.show(vc, sender: nil)
    }
}
