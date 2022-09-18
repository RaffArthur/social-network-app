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
    var mockAuthReviewer: MockAuthenticationReviewer?
    
    override func setUp() {
        super.setUp()
        
        mockAuthReviewer = MockAuthenticationReviewer()
    }
    
    func test_singin_response() {
        let expectation = expectation(description: "Some exp")

        let credentials = UserCredentials(email: "aa@aa.a",
                                          password: "aaaaaa",
                                          repeatPassword: nil,
                                          loggedIn: true)
                        
        mockAuthReviewer?.signInWith(credentials: credentials) { result in
            switch result {
            case .success:
                XCTAssertTrue(true)
            case .failure(let error):
                XCTFail("\(error.title). Описание ошибки: \(error.message)")
            }
            
            expectation.fulfill()
        }
        
        XCTAssertTrue(mockAuthReviewer?.signInWasCalled == true)
        
        waitForExpectations(timeout: 2.0)
    }
    
    func test_signout_response() {
        let expectation = expectation(description: "Some exp")

        let credentials = UserCredentials(email: "aa@aa.a",
                                          password: "aaaaaa",
                                          repeatPassword: nil,
                                          loggedIn: false)
        
        mockAuthReviewer?.signOutWith(credentials: credentials) { result in
            switch result {
            case .success:
                XCTAssertTrue(true)
            case .failure(let error):
                XCTFail("\(error.title). Описание ошибки: \(error.message)")
            }
            
            expectation.fulfill()
        }
        
        XCTAssertTrue(mockAuthReviewer?.signOutWasCalled == true)

        waitForExpectations(timeout: 2.0)
    }
    
    func test_registration_response() {
        let expectation = expectation(description: "Some exp")

        let credentials = UserCredentials(email: "aa@aa.aa",
                                          password: "aaaaaa",
                                          repeatPassword: "aaaaaa",
                                          loggedIn: true)
                
        mockAuthReviewer?.registrationWith(credentials: credentials) { result in
            switch result {
            case .success:
                XCTAssertTrue(true)
            case .failure(let error):
                XCTFail("\(error.title). Описание ошибки: \(error.message)")
            }
            
            expectation.fulfill()
        }
        
        XCTAssertTrue(mockAuthReviewer?.registrationWasCalled == true)

        waitForExpectations(timeout: 2.0)
    }
}

final class MockAuthenticationReviewer {
    var signInWasCalled = false
    var signOutWasCalled = false
    var registrationWasCalled = false
    var shouldReturnError = false
}

extension MockAuthenticationReviewer: AuthentificationReviewer {
    func signOutWith(credentials: UserCredentials,
                     completion: (Result<Any, UserAuthError>) -> Void) {
        signOutWasCalled = true
        
        if shouldReturnError {
            completion(.failure(.internalError))
        } else {
            completion(.success(true))
        }
    }
    
    func signInWith(credentials: UserCredentials, completion: @escaping UserAuthResult) {
        signInWasCalled = true
        
        if shouldReturnError {
            completion(.failure(.internalError))
        } else {
            completion(.success(true))
        }
    }
    
    func registrationWith(credentials: UserCredentials, completion: @escaping UserAuthResult) {
        registrationWasCalled = true
        
        if shouldReturnError {
            completion(.failure(.internalError))
        } else {
            completion(.success(true))
        }
    }
}
