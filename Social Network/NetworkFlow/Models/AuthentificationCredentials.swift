//
//  AuthentificationCredentials.swift
//  Social_Network
//
//  Created by Arthur Raff on 22.05.2022.
//

import Foundation
import RealmSwift

class AuthentificationCredentials: Object {
    @Persisted var email: String?
    @Persisted var password: String?
    @Persisted var loggedIn: Bool?
}
