//
//  MainProfileInfoDelegates.swift
//  Social_Network
//
//  Created by Arthur Raff on 15.10.2023.
//

import Foundation

protocol MainProfileInfoViewControllerDelegate: AnyObject {
    func cancelProfileInfoButtonWasTapped()
    func saveProfileInfoButtonWasTapped()
}

protocol MainProfileInfoViewDelegate: AnyObject {
    func birthDateWillBeSaved(date: Date)
}
