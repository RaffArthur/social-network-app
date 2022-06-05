//
//  RegistrationDelegates.swift
//  Social_Network
//
//  Created by Arthur Raff on 05.06.2022.
//

import Foundation

protocol RegistrationViewDelegate: AnyObject {
    func registrationButtonWasTapped()
    func authTypeButtonWasTapped()
}

protocol RegistrationViewConrollerDelegate: AnyObject {
    func didUserRegister()
    func didUserChooseLogin()
}
