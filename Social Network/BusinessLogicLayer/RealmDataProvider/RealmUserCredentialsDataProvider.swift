//
//  RealmUserCredentialsDataProvider.swift
//  Social_Network
//
//  Created by Arthur Raff on 22.05.2022.
//

import Foundation
import RealmSwift

protocol RealmUserCredentialsDataProvider: AnyObject {
    func addUser(credentials: UserCredentials)
    func getUserCredentials() -> UserCredentials?
    func updateUser(credentials: UserCredentials)
}
