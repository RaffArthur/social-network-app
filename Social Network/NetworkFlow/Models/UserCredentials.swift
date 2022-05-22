//
//  UserCredentials.swift
//  Social_Network
//
//  Created by Arthur Raff on 22.05.2022.
//

import Foundation

struct UserCredentials: Codable {
    let email: String?
    let password: String?
    let repeatPassword: String?
    let loggedIn: Bool?
}
