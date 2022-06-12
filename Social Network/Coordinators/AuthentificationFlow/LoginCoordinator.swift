//
//  LoginCoordinator.swift
//  Social_Network
//
//  Created by Arthur Raff on 11.10.2021.
//

import Foundation
import UIKit

final class LoginCoordinator: Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .login }
    
    private var authentifivationReviewer: AuthentificationReviewer?
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = LoginViewController()
        
        authentifivationReviewer = AuthentificationReviewerImpl()
        vc.reviewer = authentifivationReviewer
        vc.delegate = self
        
        navigationController.pushViewController(vc, animated: true)
    }
}

extension LoginCoordinator: LoginViewConrollerDelegate {
    func didUserLogin() {
        finish()
    }
    
    func didUserChooseRegistration() {
        let coordinator = RegistrationCoordinator(navigationController)
        coordinator.start()
        
        childCoordinators.append(coordinator)
    }
}


