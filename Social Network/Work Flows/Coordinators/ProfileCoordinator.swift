//
//  ProfileCoordinator.swift
//  Social_Network
//
//  Created by Arthur Raff on 09.02.2021.
//

import UIKit

@available(iOS 13.0, *)
class ProfileCoordinator: Coordinator {
    
    // MARK: - Properties
    private let loginReviewer = LoginReviewer()
    private(set) var navigationController: UINavigationController
    
    // MARK: - Coordinator Initialization
    init(navigationController: UINavigationController) {
      self.navigationController = navigationController
    }
      
    // MARK: - Launching the ProfileCoordinator
    func start() {
        let vc = LogInViewController()
        
        vc.delegate = loginReviewer
        vc.coordinator = self
        
        push(vc: vc, animated: false)
    }
    
    // MARK: - Login to ProfileVC
    func logIn() {
        let vc = ProfileViewController()
        
        vc.coordinator = self
        
        push(vc: vc, animated: true)
    }

    // MARK: - Open PhotosVC
    func openPhotoGallery() {
        let vc = PhotosViewController()
        
        vc.coordinator = self
        
        push(vc: vc, animated: true)
    }
}
