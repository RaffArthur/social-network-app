//
//  LoginReviewer.swift
//  Social_Network
//
//  Created by Arthur Raff on 09.01.2021.
//

import UIKit

@available(iOS 13.0, *)
class LoginReviewer: LoginViewControllerDelegate {

    func loginWillBeChecked(_ login: String, completion: @escaping (Bool) -> Void) {
        return completion(Checker.shared.isNameCorrect(login))
    }
    
    func passWillBeChecked(_ pass: String, completion: @escaping (Bool) -> Void) {
        return completion(Checker.shared.isPassCorrect(pass))
    }
}
