//
//  LoginViewControllerDelegate.swift
//  Social_Network
//
//  Created by Arthur Raff on 09.01.2021.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {    
    func signOut(completion: @escaping (Result<Any, AuthError>) -> Void) throws
    
    func signIn(vc: UIViewController,
                email: String,
                pass: String,
                completion: @escaping (Result<Any, AuthError>) -> Void) throws
}
