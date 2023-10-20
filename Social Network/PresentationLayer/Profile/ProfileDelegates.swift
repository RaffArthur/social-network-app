//
//  ProfileDelegates.swift
//  Social_Network
//
//  Created by Arthur Raff on 02.03.2022.
//

import Foundation
import UIKit

protocol ProfileViewControllerDelegate: AnyObject {
    func logoutButtonWasTapped()
    func photoLibraryWasTapped()
    func postWasAddedToFavourite(post: Post)
    func userEditInfoButtonWasTapped()
    func userMoreInfoButtonWasTapped()
}

protocol ProfileHeaderViewDelegate: AnyObject {
    func userEditInfoButtonTapped()
    func userMoreInfoButtonTapped()
}

protocol ProfilePostQuickActionsPanelViewDelegate: AnyObject {
    func postLikesButtonWasTapped(sender: UIButton)
    func postCommentsButtonWasTapped(sender: UIButton)
    func postAddToFavouritesButtonWasTapped(sender: UIButton)
}

protocol ProfilePostTableViewCellDelegate: AnyObject {
    func postLikesButtonWasTapped(sender: UIButton)
    func postCommentsButtonWasTapped(sender: UIButton)
    func postAddToFavouritesButtonWasTapped(sender: UIButton)
}
