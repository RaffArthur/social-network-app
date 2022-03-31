//
//  ProfileDelegates.swift
//  Social_Network
//
//  Created by Arthur Raff on 02.03.2022.
//

import Foundation

protocol ProfileViewControllerDelegate: AnyObject {
    func logoutButtonWasTapped()
    func photoLibraryWasTapped()
}

protocol ProfileHeaderViewDelegate: AnyObject {
    func userPhotoTapped()
    func userPhotoCloseButtonTapped()
    func setUserStatusButtonTapped()
}
