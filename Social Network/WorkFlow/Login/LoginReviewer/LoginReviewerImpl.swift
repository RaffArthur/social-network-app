//
//  LoginReviewerImpl.swift
//  Social_Network
//
//  Created by Arthur Raff on 09.01.2021.
//

import UIKit

import FirebaseAuth
import FirebaseFirestore

final class LoginReviewerImpl: LoginReviewer {
    func signOut(completion: UserAuthResult) throws {
        do {
            completion(.success(true))
            try Auth.auth().signOut()
        } catch {
            completion(.failure(.unknownError))
        }
    }
    
    func signIn(email: String,
                pass: String,
                completion: @escaping UserAuthResult) {
        if email.isEmpty || pass.isEmpty {
            completion(.failure(.emptyFields))
        } else {
            Auth.auth().signIn(withEmail: email, password: pass) { authResult, error in
                if error == nil {
                    guard let user = authResult?.user else { return }
                    
                    completion(.success(user))
                } else {
                    guard let nsError = error as NSError?,
                          let code = AuthErrorCode(rawValue: nsError.code)
                    else {
                        return
                    }
                    
                    if code == .invalidEmail {
                        completion(.failure(.incorrectEmail))
                    }
                    
                    if code == .userNotFound {
                        completion(.failure(.userNotFound))
                    }
                    
                    if code == .wrongPassword {
                        completion(.failure(.incorrectPass))
                    }
                    
                    if code == .tooManyRequests {
                        completion(.failure(.tooManyRequests))
                    }
                    
                    completion(.failure(.unknownError))
                }
            }
        }
    }
    
    func registration(email: String,
                      pass: String,
                      repeatPass: String,
                      completion: @escaping UserAuthResult) {
        if email.isEmpty || pass.isEmpty || repeatPass.isEmpty {
            completion(.failure(.emptyFields))
        } else if repeatPass != pass {
            completion(.failure(.passwordMissmatch))
        } else {
            Auth.auth().createUser(withEmail: email, password: pass) { authResult, error in
                if error == nil {
                    guard let user = authResult?.user else { return }

                    completion(.success(user))
                } else {
                    guard let nsError = error as NSError?,
                          let code = AuthErrorCode(rawValue: nsError.code)
                    else {
                        return
                    }
                    
                    if code == .invalidEmail {
                        completion(.failure(.incorrectEmail))
                    }
                    
                    if code == .emailAlreadyInUse {
                        completion(.failure(.existingAccount))
                    }
                                                    
                    if code == .weakPassword {
                        completion(.failure(.weakPass))
                    }
                    
                    completion(.failure(.unknownError))
                }
            }
        }
    }    
}
