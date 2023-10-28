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
    func menuButtonWasTapped() {
        let coordinator = ProfileMenuCoordinator(navigationController)
        coordinator.start()
        
        coordinator.logOutted = { [weak self] in
            self?.logOutted?()
            self?.finish()
        }
        
        childCoordinators.append(coordinator)
    }
    
//    func postWasAddedToFavourite(post: Post) {
//        CoreDataManager.shared.saveToFavourite(post: post)
//    }
    
    func photoLibraryWasTapped() {
        let coordinator = PhotosCoordinator(navigationController)
        coordinator.start()

        childCoordinators.append(coordinator)
    }
    
    func userEditInfoButtonWasTapped() {
//        let coordinator = MainProfileInfoCoordinator(navigationController)
//        coordinator.start()
//        
//        childCoordinators.append(coordinator)
        
        let coordinator = PostCreatingCoordinator(navigationController)
        coordinator.start()
        
        childCoordinators.append(coordinator)
    }
    
    func userMoreInfoButtonWasTapped() {
        let coordinator = ProfileDetailedInfoCoodinator(navigationController)
        coordinator.start()
        
        childCoordinators.append(coordinator)
    }
}
