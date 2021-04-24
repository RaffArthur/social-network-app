//
//  LogInViewControllerDelegate.swift
//  Social_Network
//
//  Created by Arthur Raff on 09.01.2021.
//

import UIKit

typealias ThrowsCallback = (Bool) throws -> Void

protocol LoginViewControllerDelegate: class {
    func loginWillBeChecked(_ login: String, vc: UIViewController, completion: @escaping ThrowsCallback) throws
    func passWillBeChecked(_ pass: String, vc: UIViewController, completion: @escaping ThrowsCallback) throws
}
