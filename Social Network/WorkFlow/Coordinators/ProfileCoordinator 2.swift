//
//  ProfileCoordinator.swift
//  Social_Network
//
//  Created by Arthur Raff on 09.02.2021.
//

import UIKit

@available(iOS 13.0, *)
class ProfileCoordinator: Coordinator {
    private let loginReviewer = LoginReviewer()
    private(set) var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
      self.navigationController = navigationController
    }
      
    func start() {
        let vc = LogInViewController()
        
        vc.delegate = loginReviewer
        vc.coordinator = self
        
        push(vc: vc, animated: false)
    }
    
    func logIn() {
        let vc = ProfileViewController()
        
        vc.coordinator = self
        
        push(vc: vc, animated: true)
    }

    func openPhotoGallery() {
        let vc = PhotosViewController()
        
        vc.coordinator = self
        
        push(vc: vc, animated: true)
    }
}
