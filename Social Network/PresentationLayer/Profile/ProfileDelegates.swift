//
//  ProfileDelegates.swift
//  Social_Network
//
//  Created by Arthur Raff on 02.03.2022.
//

import Foundation
import UIKit

protocol ProfileViewControllerDelegate: AnyObject {
    func menuButtonWasTapped()
    func photoLibraryWasTapped()
//    func postWasAddedToFavourite(post: Post)
    func userPublishPostButtonWasTapped()
    func userMoreInfoButtonWasTapped()
}

protocol ProfileHeaderViewDelegate: AnyObject {
    func userPublishPostButtonWasTapped()
    func userMoreInfoButtonTapped()
}

protocol ProfilePostQuickActionsPanelViewDelegate: AnyObject {
    func postLikesButtonWasTapped(indexPath: IndexPath)
    func postCommentsButtonWasTapped(indexPath: IndexPath)
    func postAddToFavouritesButtonWasTapped(indexPath: IndexPath)
}

protocol ProfilePostTableViewCellDelegate: AnyObject {
    func postLikesButtonWasTapped(indexPath: IndexPath)
    func postCommentsButtonWasTapped(indexPath: IndexPath)
    func postAddToFavouritesButtonWasTapped(indexPath: IndexPath)
}
