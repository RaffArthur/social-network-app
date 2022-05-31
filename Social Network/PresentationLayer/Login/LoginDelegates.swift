//
//  LoginDelegates.swift
//  Social_Network
//
//  Created by Arthur Raff on 22.02.2022.
//

import Foundation

protocol LoginViewDelegate: AnyObject {
    func loginButtonWasTapped()
    func registrationButtonWasTapped()
    func loginTypeButtonWasTapped()
}

protocol LoginViewConrollerDelegate: AnyObject {
    func userLoggedIn()
}
