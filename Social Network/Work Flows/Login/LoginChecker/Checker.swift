//
//  Checker.swift
//  Social_Network
//
//  Created by Arthur Raff on 09.01.2021.
//

import UIKit

@available(iOS 13.0, *)
class Checker {
    static var shared: Checker = {
        let instance = Checker()
        
        return instance
    }()
    
    var login = "Alex"
    var pass = "1234"
    var loginRev = LoginReviewer()
    private init() { }
    
    func isNameCorrect(_ login: String) -> Bool {
        return login == self.login
    }
    
    func isPassCorrect(_ pass: String) -> Bool {
        return pass == self.pass
    }
}

@available(iOS 13.0, *)
extension Checker: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
