//
//  LoginReviewerImpl.swift
//  Social_Network
//
//  Created by Arthur Raff on 09.01.2021.
//

import UIKit

import FirebaseAuth
import FirebaseFirestore
import RealmSwift

final class LoginReviewerImpl: LoginReviewer {
    private let realmDataProvider: RealmUserCredentialsDataProvider = RealmUserCredentialsDataProviderImpl()
    
    private let errorCodeConverter: AuthErrorCodeConverter = AuthErrorCodeConverterImpl()
    
    func signOutWith(credentials: UserCredentials, completion: UserAuthResult) {
        do {
            completion(.success(true))
            
            realmDataProvider.updateUser(credentials: credentials)
                        
            try Auth.auth().signOut()
        } catch {
            completion(.failure(.keyсhainError))
        }
    }
    
    func signInWith(credentials: UserCredentials,
                    completion: @escaping UserAuthResult) {
        guard let email = credentials.email,
              let password = credentials.password
        else {
            return
        }
        
        let inputDataValidationError = signInValidation(email: email,
                                                        pass: password)
        
        guard inputDataValidationError == nil else {
            inputDataValidationError.flatMap { completion(.failure($0))}
            
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            guard error == nil else {
                if let nsError = error as NSError?,
                   let code = AuthErrorCode.Code(rawValue: nsError.code){
                    
                    guard let bussinesLogicError = self.errorCodeConverter.convertAuthError(code: code) else { return }
                    completion(.failure(bussinesLogicError))
                } else {
                    completion(.failure(.unknownError))
                }
                
                return
            }
            
            guard let user = authResult?.user else { return }
            
            let realmUser = self.realmDataProvider.getUserCredentials()
            
            self.realmDataProvider.updateUser(credentials: credentials)
            
            if realmUser == nil {
                self.realmDataProvider.addUser(credentials: credentials)
            }
            
            completion(.success(user))
        }
    }
    
    func registrationWith(credentials: UserCredentials,
                          completion: @escaping UserAuthResult) {
        guard let email = credentials.email,
              let password = credentials.password,
              let repeatPassword = credentials.repeatPassword
        else {
            return
        }
        
        let inputDataValidationError = registrationValidation(email: email,
                                                              pass: password,
                                                              repeatPass: repeatPassword)
        guard inputDataValidationError == nil else {
            inputDataValidationError.flatMap { completion(.failure($0))}
            
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: repeatPassword) { [weak self] authResult, error in
            guard let self = self else { return }
            
            guard error == nil else {
                if let nsError = error as NSError?,
                   let code = AuthErrorCode.Code(rawValue: nsError.code) {
                    
                    guard let bussinesLogicError = self.errorCodeConverter.convertAuthError(code: code) else { return }
                    completion(.failure(bussinesLogicError))
                } else {
                    completion(.failure(.unknownError))
                }
                
                return
            }
            
            guard let user = authResult?.user else { return }
            
            self.realmDataProvider.addUser(credentials: credentials)
            
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
