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
    func userPostWasTapped(userID: String,
                           postID: String,
                           post: UserPost,
                           userName: String,
                           userRegalia: String,
                           indexPath: IndexPath,
                           isPostLiked: Bool,
                           isPostAddedToFavourite: Bool) {
        let coordinator = PostDetailsCoordinator(navigationController)
        coordinator.startWith(userID: userID,
                              postID: postID,
                              post: post,
                              userName: userName,
                              userRegalia: userRegalia,
                              indexPath: indexPath,
                              isPostLiked: isPostLiked,
                              isPostAddedToFavourite: isPostAddedToFavourite)
        
        childCoordinators.append(coordinator)
    }
    
    func menuButtonWasTapped() {
        let coordinator = ProfileMenuCoordinator(navigationController)
        coordinator.start()
        
        coordinator.logOutted = { [weak self] in
            self?.logOutted?()
            self?.finish()
        }
        
        childCoordinators.append(coordinator)
    }
    
    func photoLibraryWasTapped() {
        let coordinator = PhotosCoordinator(navigationController)
        coordinator.start()

        childCoordinators.append(coordinator)
    }
    
    func userPublishPostButtonWasTapped() {
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
