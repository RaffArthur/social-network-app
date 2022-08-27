//
//  RegistrationCoordinator.swift
//  Social_Network
//
//  Created by Arthur Raff on 05.06.2022.
//

import Foundation
import UIKit

final class RegistrationCoordinator: Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .registration }
    
    private var authentifivationReviewer: AuthentificationReviewer?
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = RegistrationViewController()
        
        authentifivationReviewer = AuthentificationReviewerImpl()
        vc.reviewer = authentifivationReviewer
        vc.delegate = self
        
        navigationController.show(vc, sender: nil)
    }
}

extension RegistrationCoordinator: RegistrationViewConrollerDelegate {
    func didUserRegister() {
        finish()
    }
    
    func didUserChooseLogin() {
        navigationController.popViewController(animated: true)
    }
}
