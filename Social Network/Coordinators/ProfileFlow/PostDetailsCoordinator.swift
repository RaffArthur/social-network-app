//
//  PostDetailsCoordinator.swift
//  Social_Network
//
//  Created by Arthur Raff on 04.11.2023.
//

import Foundation
import UIKit

final class PostDetailsCoordinator: Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .postDetails }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
    }
    
    func startWith(userID: String,
                   postID: String,
                   post: UserPost,
                   userName: String,
                   userRegalia: String,
                   indexPath: IndexPath,
                   isPostLiked: Bool,
                   isPostAddedToFavourite: Bool) {
        let vc = PostDetailsViewController()
        vc.configureView(userID: userID,
                         postID: postID,
                         post: post,
                         userName: userName,
                         userRegalia: userRegalia,
                         indexPath: indexPath,
                         isPostLiked: isPostLiked,
                         isPostAddedToFavourite: isPostAddedToFavourite)
        
        navigationController.tabBarController?.tabBar.isHidden = true
        
        navigationController.pushViewController(vc, animated: true)
    }
}
