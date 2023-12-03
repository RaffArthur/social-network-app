//
//  FirebaseDatabaseError.swift
//  Social_Network
//
//  Created by Arthur Raff on 26.11.2023.
//

import Foundation

enum FirebaseDatabaseError: Error {
    case currentUserIDMissing
    case permissionDenied
    case databaseError
    case invalidData
    case childByAutoIDMissing
    case emptyBody
}
