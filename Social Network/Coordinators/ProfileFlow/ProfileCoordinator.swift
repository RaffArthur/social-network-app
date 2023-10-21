//
//  ProfileCoordinator.swift
//  Social_Network
//
//  Created by Arthur Raff on 13.10.2021.
//

import UIKit

final class ProfileCoordinator: Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController 
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .profile }
    
    var logOutted: (() -> Void)?
    
    private var authentificationReviewer: AuthentificationReviewer?
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ProfileViewController()
        
        authentificationReviewer = AuthentificationReviewerImpl()
        vc.reviewer = authentificationReviewer
        vc.delegate = self
        
        navigationController.pushViewController(vc, animated: true)
    }
}

extension ProfileCoordinator: ProfileViewControllerDelegate {
    func postWasAddedToFavourite(post: Post) {
        CoreDataManager.shared.saveToFavourite(post: post)
    }
    
    func logoutButtonWasTapped() {
        logOutted?()
    }
    
    func photoLibraryWasTapped() {
        let coordinator = PhotosCoordinator(navigationController)
        coordinator.start()

        childCoordinators.append(coordinator)
    }
    
    func userEditInfoButtonWasTapped() {
        let coordinator = MainProfileInfoCoordinator(navigationController)
        coordinator.start()
        
        childCoordinators.append(coordinator)
    }
    
    func userMoreInfoButtonWasTapped() {
        
    }
}
