//
//  LoginReviewer.swift
//  Social_Network
//
//  Created by Arthur Raff on 09.01.2021.
//

import UIKit

protocol LoginReviewer: AnyObject {
    typealias UserAuthResult = (Result<Any, UserAuthError>) -> Void
    
    func signOut(completion: UserAuthResult) throws
    
    func signIn(email: String,
                pass: String,
                completion: @escaping UserAuthResult)
    
    func registration(email: String,
                      pass: String,
                      repeatPass: String,
                      completion: @escaping UserAuthResult)
}
