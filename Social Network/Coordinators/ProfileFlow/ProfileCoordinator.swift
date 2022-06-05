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
        let profileVC = ProfileViewController()
        
        authentificationReviewer = AuthentificationReviewerImpl()
        profileVC.reviewer = authentificationReviewer
        profileVC.delegate = self
        
        navigationController.pushViewController(profileVC, animated: true)
    }
}

extension ProfileCoordinator: ProfileViewControllerDelegate {
    func postWasTapped(post: Post) {
        CoreDataManager.shared.saveToFavourite(post: post)
    }
    
    func logoutButtonWasTapped() {
        logOutted?()
    }
    
    func photoLibraryWasTapped() {
        let coordinator = PhotosCoordinator(navigationController)
        
        childCoordinators.append(coordinator)
        
        coordinator.start()
    }
}
