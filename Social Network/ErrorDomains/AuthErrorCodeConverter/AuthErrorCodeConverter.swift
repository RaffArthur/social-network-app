//
//  AuthErrorCodeConverter.swift
//  Social_Network
//
//  Created by Arthur Raff on 01.03.2022.
//

import Foundation
import FirebaseAuth

protocol AuthErrorCodeConverter {
    func convertAuthError(code: AuthErrorCode) -> UserAuthError?
}
