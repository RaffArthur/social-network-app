//
//  RealmErrorCodeConverterImpl.swift
//  Social_Network
//
//  Created by Arthur Raff on 24.05.2022.
//

import Foundation
import RealmSwift

final class RealmErrorCodeConverterImpl: RealmErrorCodeConverter {
    func convertRealmError(code: Realm.Error.Code) -> RealmError? {
        switch code {
        case .fail:
            return .realmFail
        case .fileAccess,
             .filePermissionDenied,
             .fileExists,
             .fileNotFound,
             .fileFormatUpgradeRequired,
             .incompatibleLockFile,
             .alreadyOpen,
             .invalidInput,
             .outOfDiskSpace,
             .incompatibleSession,
             .unsupportedFileFormatVersion,
             .multipleSyncAgents,
             .subscriptionFailed,
             .fileOperationFailed,
             .invalidDatabase,
             .incompatibleHistories,
             .noSubscriptionForWrite:
            return .fileFail
        case .addressSpaceExhausted:
            return .addressSpaceFail
        case .schemaMismatch:
            return .schemaFail
        }
    }
}
