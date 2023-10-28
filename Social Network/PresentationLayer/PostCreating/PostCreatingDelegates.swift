//
//  PostCreatingDelegates.swift
//  Social_Network
//
//  Created by Arthur Raff on 28.10.2023.
//

import Foundation

protocol PostCreatingViewDelegate: AnyObject {
    func addImageButtonWasTapped()
}

protocol PostCreatingViewControllerDelegate: AnyObject {
    func cancelCreatingPostButtonWasTapped()
    func publishPostButtonWasTapped()
}
