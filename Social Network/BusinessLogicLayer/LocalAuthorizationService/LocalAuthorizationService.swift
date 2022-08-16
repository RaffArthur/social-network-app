//
//  LocalAuthorizationService.swift
//  Social_Network
//
//  Created by Arthur Raff on 16.08.2022.
//

import Foundation
import LocalAuthentication

final class LocalAuthorizationService {
    func authorizeIfPossible(finished: @escaping (Bool) -> Void) {
        let context = LAContext()
        let policy: LAPolicy = .deviceOwnerAuthentication
        var error: NSError?
        
        if context.canEvaluatePolicy(policy, error: &error) {
            context.evaluatePolicy(policy,
                                   localizedReason: .localized(key: .localAuthentificationReason)) { [weak self] success, error in
                
                DispatchQueue.main.async { [weak self] in
                    guard error == nil else { return }

                    if success {
                        finished(true)
                    } else {
                        finished(false)
                    }
                }
            }
        }
    }
}
