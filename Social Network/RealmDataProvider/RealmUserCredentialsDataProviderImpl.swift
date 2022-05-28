//
//  RealmUserCredentialsDataProviderImpl.swift
//  Social_Network
//
//  Created by Arthur Raff on 22.05.2022.
//

import Foundation
import RealmSwift

final class RealmUserCredentialsDataProviderImpl: RealmUserCredentialsDataProvider {
    private let errorCodeConverter: RealmErrorCodeConverter = RealmErrorCodeConverterImpl()

    func addUser(credentials: UserCredentials) {
        let user = UserCredentialsCached()
        user.email = credentials.email
        user.password = credentials.password
        user.loggedIn = credentials.loggedIn
        
        do {
            let realm = try Realm()
            
            let block: () -> Void = {
                realm.add(user)
            }
            
            if realm.isInWriteTransaction {
                block()
            } else {
                try realm.write {
                    block()
                }
            }
        } catch let error as NSError {
            guard let code = Realm.Error.Code(rawValue: error.code) else { return }
            
            guard let businessLogicError = errorCodeConverter.convertRealmError(code: code) else {
                return
            }
            
            debugPrint(businessLogicError.localizedDescription)
        }
    }
    
    func getUserCredentials() -> UserCredentials? {
        let realm = try? Realm()
        
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
        let realm = try? Realm()
        
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
