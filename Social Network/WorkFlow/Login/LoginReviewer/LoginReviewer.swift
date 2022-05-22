//
//  LoginReviewer.swift
//  Social_Network
//
//  Created by Arthur Raff on 09.01.2021.
//

import UIKit

protocol LoginReviewer: AnyObject {
    typealias UserAuthResult = (Result<Any, UserAuthError>) -> Void
    
    func signOutWith(credentials: UserCredentials, completion: UserAuthResult)
    func signInWith(credentials: UserCredentials, completion: @escaping UserAuthResult)
    func registrationWith(credentials: UserCredentials, completion: @escaping UserAuthResult)
}
