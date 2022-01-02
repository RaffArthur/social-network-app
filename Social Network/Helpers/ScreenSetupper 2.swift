//
//  ScreenSetupper.swift
//  Social_Network
//
//  Created by Arthur Raff on 09.08.2021.
//

import UIKit

@objc public protocol ScreenSetupper: AnyObject {
    @objc optional func setupScreen()

    @objc optional func setupLayout()
    
    @objc optional func setupContent()
}
