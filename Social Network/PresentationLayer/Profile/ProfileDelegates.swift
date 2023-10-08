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
    func postWasTapped(post: Post)
}

protocol ProfileHeaderViewDelegate: AnyObject {
    func userEditInfoButtonTapped()
    func userMoreInfoButtonTapped()
}
