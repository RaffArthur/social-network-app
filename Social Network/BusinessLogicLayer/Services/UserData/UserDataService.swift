//
//  UserDataService.swift
//  Social_Network
//
//  Created by Arthur Raff on 16.10.2023.
//

import Foundation
import Firebase
import FirebaseFirestore

typealias GetUserDataResult = (Result<UserData, UserMainProfileInfoError>) -> Void
typealias SaveUserDataResult = (Result<Any, UserMainProfileInfoError>) -> Void

protocol UserDataService: AnyObject {
    func getUserData(completion: @escaping GetUserDataResult)
    func saveUserData(userData: UserData, completion: @escaping SaveUserDataResult)
}
