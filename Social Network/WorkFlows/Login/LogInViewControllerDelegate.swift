//
//  LogInViewControllerDelegate.swift
//  Social_Network
//
//  Created by Arthur Raff on 09.01.2021.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func loginWillBeChecked(_ login: String, vc: UIViewController, completion: @escaping (Bool) throws -> Void) throws
    
    func passWillBeChecked(_ pass: String, vc: UIViewController, completion: @escaping (Bool) throws -> Void) throws
}
