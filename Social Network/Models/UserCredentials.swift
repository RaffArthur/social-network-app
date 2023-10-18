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

struct UserData: Codable {
    let name: String?
    let surname: String?
    let nickname: String?
    let regalia: String?
    let hometown: String?
    let birthDate: String?
    let gender: String?
    let isGenderSelected: Bool?
}
