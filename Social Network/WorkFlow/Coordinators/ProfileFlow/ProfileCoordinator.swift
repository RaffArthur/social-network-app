//
//  ProfileCoordinator.swift
//  Social_Network
//
//  Created by Arthur Raff on 13.10.2021.
//

import UIKit

@available(iOS 13.0, *)
class ProfileCoordinator: Coordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController 
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .profile }
    
    var logOutted: (() -> Void)?
    private var loginReviewer: LoginReviewer?
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let profileVC = ProfileViewController()
        
        loginReviewer = LoginReviewer()
        profileVC.delegate = loginReviewer
        
        profileVC.didSendEventClosure = { [weak self] event in
            guard let self = self else { return }
            
            switch event {
            case .openPhotoLibrary:
                let coordinator = PhotosCoordinator(self.navigationController)
                coordinator.start()
                
            case .signOut:
                self.logOutted?()
            }
        }
        
        navigationController.pushViewController(profileVC, animated: true)
    }
}
