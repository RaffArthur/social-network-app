//
//  PostDetailsDelegates.swift
//  Social_Network
//
//  Created by Arthur Raff on 04.11.2023.
//

import Foundation

protocol PostCommentPanelViewDelegate: AnyObject {
    func sendCommentButtonWasTapped(withText: String)
}

protocol PostDetailsViewDelegate: AnyObject {
    func sendCommentButtonWasTapped(withText: String)
}
