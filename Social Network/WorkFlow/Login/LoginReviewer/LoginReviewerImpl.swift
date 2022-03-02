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
    private let errorCodeConverter: AuthErrorCodeConverter = AuthErrorCodeConverterImpl()
    
    func signOut(completion: UserAuthResult) {
        do {
            completion(.success(true))
            try Auth.auth().signOut()
        } catch {
            completion(.failure(.keyсhainError))
        }
    }
    
    func signIn(email: String,
                pass: String,
                completion: @escaping UserAuthResult) {
        let inputDataValidationError = signInValidation(email: email,
                                                        pass: pass)
        
        guard inputDataValidationError == nil else {
            inputDataValidationError.flatMap { completion(.failure($0))}
            
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: pass) { [weak self] authResult, error in
            guard let self = self else { return }
            
            guard error == nil else {
                if let nsError = error as NSError?,
                   let code = AuthErrorCode(rawValue: nsError.code) {
                    
                    guard let bussinesLogicError = self.errorCodeConverter.convertAuthError(code: code) else { return }
                    completion(.failure(bussinesLogicError))
                } else {
                    completion(.failure(.unknownError))
                }
                
                return
            }
            
            guard let user = authResult?.user else { return }
            completion(.success(user))
        }
    }
    
    func registration(email: String,
                      pass: String,
                      repeatPass: String,
                      completion: @escaping UserAuthResult) {
        let inputDataValidationError = registrationValidation(email: email,
                                                              pass: pass,
                                                              repeatPass: repeatPass)
        guard inputDataValidationError == nil else {
            inputDataValidationError.flatMap { completion(.failure($0))}
            
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: pass) { [weak self] authResult, error in
            guard let self = self else { return }
            
            guard error == nil else {
                if let nsError = error as NSError?,
                   let code = AuthErrorCode(rawValue: nsError.code) {
                    
                    guard let bussinesLogicError = self.errorCodeConverter.convertAuthError(code: code) else { return }
                    completion(.failure(bussinesLogicError))
                } else {
                    completion(.failure(.unknownError))
                }
                
                return
            }
            
            guard let user = authResult?.user else { return }
            completion(.success(user))
        }
    }
}

private extension LoginReviewerImpl {
    func registrationValidation(email: String,
                                pass: String,
                                repeatPass: String) -> UserAuthError? {
        if email.isEmpty || pass.isEmpty || repeatPass.isEmpty {
            return .emptyFields
        } else if repeatPass != pass {
            return .passwordMissmatch
        }
        
        return nil
    }
    
    func signInValidation(email: String,
                          pass: String) -> UserAuthError? {
        if email.isEmpty || pass.isEmpty {
            return .emptyFields
        }
        
        return nil
    }
}
