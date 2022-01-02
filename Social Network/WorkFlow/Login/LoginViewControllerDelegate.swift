//
//  LoginViewControllerDelegate.swift
//  Social_Network
//
//  Created by Arthur Raff on 09.01.2021.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    
    // MARK: - User SignOut
    /// Метод выхода юзера из профиля
    func signOut(completion: @escaping (Result<Any, AuthErrors>) -> Void) throws
    
    // MARK: - User SignIn
    /// Метод входа юзера в профиль
    func signIn(vc: UIViewController, email: String, pass: String, completion: @escaping (Result<Any, AuthErrors>) -> Void) throws
}
