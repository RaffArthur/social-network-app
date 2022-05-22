//
//  RealmUserCredentialsDataProviderImpl.swift
//  Social_Network
//
//  Created by Arthur Raff on 22.05.2022.
//

import Foundation
import RealmSwift

final class RealmUserCredentialsDataProviderImpl: RealmUserCredentialsDataProvider {
    let realm = try? Realm()

    func addUser(credentials: UserCredentials) {
        let user = UserCredentialsCached()
        user.email = credentials.email
        user.password = credentials.password
        user.loggedIn = credentials.loggedIn
                
        try? realm?.write {
            realm?.add(user)
        }
    }
    
    func getUserCredentials() -> UserCredentials? {
        guard let users = realm?.objects(UserCredentialsCached.self) else { return nil }
        
        for user in users {
            return UserCredentials(email: user.email,
                                   password: user.password,
                                   repeatPassword: nil,
                                   loggedIn: user.loggedIn)
        }
        
        return nil
    }
    
    func updateUser(credentials: UserCredentials) {
        guard let users = realm?.objects(UserCredentialsCached.self) else { return }
        
        for user in users {
            try? realm?.write {
                user.email = credentials.email
                user.password = credentials.password
                user.loggedIn = credentials.loggedIn
            }
        }
    }
}
