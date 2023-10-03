//
//  AuthenticationReviewerTests.swift
//  Social_NetworkTests
//
//  Created by Arthur Raff on 10.09.2022.
//

import Foundation
import XCTest
import Firebase
@testable import Social_Network

final class AuthenticationReviewerTests: XCTestCase {
    var mockAuthReviewer: MockAuthenticationReviewer!
    
    override func setUp() {
        super.setUp()
        
        mockAuthReviewer = MockAuthenticationReviewer()
    }
    
    func test_singin_response() {
        let credentials = UserCredentials(email: "aa@aa.aa",
                                          password: "aaaaaa",
                                          repeatPassword: nil,
                                          loggedIn: true)
                
        let expectation = expectation(description: "Singin expectation")
                
        mockAuthReviewer.signInWith(credentials: credentials) { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
            case .failure(let error):
                XCTFail("Ошибка: \(error.title). Описание ошибки: \(error.message)")
            }
            
            expectation.fulfill()
        }
        
        XCTAssertTrue(mockAuthReviewer.signInWasCalled)
        XCTAssertFalse(mockAuthReviewer.shouldReturnError)
        
        waitForExpectations(timeout: 2.0)
    }
    
    func test_signout_response() {
        let credentials = UserCredentials(email: "aa@aa.aa",
                                          password: "aaaaaa",
                                          repeatPassword: nil,
                                          loggedIn: false)
        
        let expectation = expectation(description: "Singout expectation")
        
        mockAuthReviewer?.signOutWith(credentials: credentials) { result in
            switch result {
            case .success(let response):
                XCTAssertTrue(response as! Bool)
            case .failure(let error):
                XCTFail("Ошибка: \(error.title). Описание ошибки: \(error.message)")
            }
            
            expectation.fulfill()
        }
        
        XCTAssertTrue(mockAuthReviewer.signOutWasCalled)
        XCTAssertFalse(mockAuthReviewer.shouldReturnError)
        
        waitForExpectations(timeout: 2.0)
    }
    
    func test_registration_response() {
        let expectation = expectation(description: "Registration expectation")

        let credentials = UserCredentials(email: "aa@aa.aas",
                                          password: "aaaaaa",
                                          repeatPassword: "aaaaaa",
                                          loggedIn: true)
                
        mockAuthReviewer?.registrationWith(credentials: credentials) { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
            case .failure(let error):
                XCTFail("Ошибка: \(error.title). Описание ошибки: \(error.message)")
            }
            
            expectation.fulfill()
        }
        
        XCTAssertTrue(mockAuthReviewer.registrationWasCalled)
        XCTAssertFalse(mockAuthReviewer.shouldReturnError)

        waitForExpectations(timeout: 2.0)
    }
}

final class MockAuthenticationReviewer {
    var signInWasCalled = false
    var signOutWasCalled = false
    var registrationWasCalled = false
    var shouldReturnError: Bool = Bool()
    
    let errorCodeConverter: AuthErrorCodeConverter = AuthErrorCodeConverterImpl()
    let realmDataProvider: RealmUserCredentialsDataProvider = RealmUserCredentialsDataProviderImpl()

}

extension MockAuthenticationReviewer: AuthentificationReviewer {
    func signOutWith(credentials: UserCredentials,
                     completion: UserAuthResult) {
        signOutWasCalled = true
        
        do {
            shouldReturnError = false
            
            completion(.success(true))
            
            realmDataProvider.updateUser(credentials: credentials)
            
            try Auth.auth().signOut()
        } catch {
            shouldReturnError = true
            
            completion(.failure(.keyсhainError))
        }
    }
    
    func signInWith(credentials: UserCredentials,
                    completion: @escaping UserAuthResult) {
        signInWasCalled = true
        
        guard let userEmail = credentials.email,
              let userPassword = credentials.password
        else {
            return
        }
        
        Auth.auth().signIn(withEmail: userEmail,
                           password: userPassword) { authResult, error in
            guard error == nil else {
                self.shouldReturnError = true
                
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
            
            self.shouldReturnError = false
            
            completion(.success(user))
        }
    }
    
    func registrationWith(credentials: UserCredentials,
                          completion: @escaping UserAuthResult) {
        registrationWasCalled = true
        
        guard let userEmail = credentials.email,
              let userPassword = credentials.password
        else {
            return
        }
        
        Auth.auth().createUser(withEmail: userEmail,
                               password: userPassword) { authResult, error in
            
            guard error == nil else {
                self.shouldReturnError = true
                
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
            
            self.shouldReturnError = false
            
            completion(.success(user))
        }
    }
}
