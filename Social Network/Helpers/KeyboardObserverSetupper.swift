//
//  KeyboardObserverSetupper.swift
//  Social_Network
//
//  Created by Arthur Raff on 13.08.2021.
//

import UIKit

@objc public protocol KeyboardObserverSetupper: AnyObject {
    @objc optional func addKeyboardObserver()
    
    @objc optional func removeKeyboardObserver()
    
    @objc optional func keyboardWillShow(notification: NSNotification)
    
    @objc optional func keyboardWillHide(notification: NSNotification)
}
