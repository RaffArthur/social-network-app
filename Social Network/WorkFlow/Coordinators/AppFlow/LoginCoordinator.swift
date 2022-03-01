//
//  LoginCoordinator.swift
//  Social_Network
//
//  Created by Arthur Raff on 11.10.2021.
//

import UIKit

@available(iOS 13.0, *)
final class LoginCoordinator: Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .login }
    
    private var loginReviewer: LoginReviewer?
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginVC = LoginViewController()
        
        loginReviewer = LoginReviewerImpl()
        loginVC.reviewer = loginReviewer
        loginVC.delegate = self
        
        navigationController.pushViewController(loginVC, animated: true)
    }
}

@available(iOS 13.0, *)
extension LoginCoordinator: LoginViewConrollerDelegate {
    func userLoggedIn() {
        finish()
    }
}


