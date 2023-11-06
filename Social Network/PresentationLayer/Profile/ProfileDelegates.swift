//
//  ProfileDelegates.swift
//  Social_Network
//
//  Created by Arthur Raff on 02.03.2022.
//

import Foundation

protocol ProfileViewControllerDelegate: AnyObject {
    func menuButtonWasTapped()
    func photoLibraryWasTapped()
    func userPublishPostButtonWasTapped()
    func userMoreInfoButtonWasTapped()
    func userPostWasTapped(userID: String,
                           postID: String,
                           post: UserPost,
                           userName: String,
                           userRegalia: String,
                           indexPath: IndexPath,
                           isPostLiked: Bool,
                           isPostAddedToFavourite: Bool)
}

protocol ProfileHeaderViewDelegate: AnyObject {
    func userPublishPostButtonWasTapped()
    func userMoreInfoButtonTapped()
}

protocol ProfilePostQuickActionsPanelViewDelegate: AnyObject {
    func postLikesButtonWasTappedAt(index: Int)
    func postCommentsButtonWasTappedAt(index: Int)
    func postAddToFavouritesButtonWasTappedAt(index: Int)
}

protocol ProfilePostTableViewCellDelegate: AnyObject {
    func postLikesButtonWasTappedAt(index: Int)
    func postCommentsButtonWasTappedAt(index: Int)
    func postAddToFavouritesButtonWasTappedAt(index: Int)
}
