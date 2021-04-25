//
//  LoginReviewer.swift
//  Social_Network
//
//  Created by Arthur Raff on 09.01.2021.
//

import UIKit

@available(iOS 13.0, *)
class LoginReviewer: LoginViewControllerDelegate {
    func loginWillBeChecked(_ login: String,
                            vc: UIViewController,
                            completion: @escaping ThrowsCallback) throws {
        try completion(Checker.shared.isNameCorrect(login))
    }
    
    func passWillBeChecked(_ pass: String,
                           vc: UIViewController,
                           completion: @escaping ThrowsCallback) throws {
        try completion(Checker.shared.isPassCorrect(pass))
    }
}
