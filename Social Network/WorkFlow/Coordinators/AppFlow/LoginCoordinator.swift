//
//  LoginCoordinator.swift
//  Social_Network
//
//  Created by Arthur Raff on 11.10.2021.
//

import UIKit

protocol LoginCoordinatorProtocol: Coordinator {
    func showLoginViewController()
}

@available(iOS 13.0, *)
class LoginCoordinator: LoginCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .login }
    
    private var loginReviewer: LoginReviewer?
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showLoginViewController()
    }
    
    func showLoginViewController() {
        let loginVC = LoginViewController()
        
        loginReviewer = LoginReviewer()
        loginVC.delegate = loginReviewer
        
        loginVC.didSendEventClosure = { [weak self] event in
            guard let self = self else { return }
            
            switch event {
            case .userLogged:
                self.finish()
            }
        }
        
        navigationController.pushViewController(loginVC, animated: true)
    }
}


