//
//  RealmErrorCodeConverter.swift
//  Social_Network
//
//  Created by Arthur Raff on 24.05.2022.
//

import Foundation
import RealmSwift

protocol RealmErrorCodeConverter {
    func convertRealmError(code: Realm.Error.Code) -> RealmError?
}
