//
//  ProfileCoordinator.swift
//  Social_Network
//
//  Created by Arthur Raff on 13.10.2021.
//

import UIKit

final class ProfileCoordinator: Coordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController 
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .profile }
    
    var logOutted: (() -> Void)?
    private var loginReviewer: LoginReviewer?
    let favouritePosts = CoreDataManager.shared.fetchFavouritePosts()

    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let profileVC = ProfileViewController()
        
        loginReviewer = LoginReviewerImpl()
        profileVC.reviewer = loginReviewer
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
        
        coordinator.start()
    }
}
