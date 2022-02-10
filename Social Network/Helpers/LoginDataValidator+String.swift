//
//  LoginDataValidator.swift
//  Social_Network
//
//  Created by Arthur Raff on 08.10.2021.
//

import UIKit

extension String {
    public func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    public func isValidPass() -> Bool {
        let minimumPassRegEx = ".{6,}"
        let passRegEx = "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$"

        let passPred = NSPredicate(format:"SELF MATCHES %@", minimumPassRegEx)
        return passPred.evaluate(with: self)
    }
}
