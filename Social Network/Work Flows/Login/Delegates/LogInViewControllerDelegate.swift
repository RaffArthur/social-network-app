//
//  LogInViewControllerDelegate.swift
//  Social_Network
//
//  Created by Arthur Raff on 09.01.2021.
//

import UIKit

protocol LoginViewControllerDelegate: class {
    func loginWillBeChecked(_ login: String, completion: @escaping (Bool) -> Void)
    func passWillBeChecked(_ pass: String, completion: @escaping (Bool) -> Void)
}
