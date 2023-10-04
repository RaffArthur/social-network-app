//
//  AuthErrorCodeConverterImpl.swift
//  Social_Network
//
//  Created by Arthur Raff on 01.03.2022.
//

import Foundation
import FirebaseAuth

final class AuthErrorCodeConverterImpl: AuthErrorCodeConverter {
    func convertAuthError(code: AuthErrorCode.Code) -> UserAuthError? {
        switch code {
            case .wrongPassword:
                return .wrongPassword
            case .invalidEmail:
                return .invalidEmail
            case .tooManyRequests:
                return .tooManyRequests
            case .userNotFound:
                return .userNotFound
            case .emailAlreadyInUse:
                return .emailAlreadyInUse
            case .weakPassword:
                return .weakPassword
            case .invalidCredential:
                return .invalidCredential
            case .userDisabled:
                return .userDisabled
            case .requiresRecentLogin:
                return .requiresRecentLogin
            case .networkError:
                return .networkError
            case .internalError:
                return .internalError
            case .keychainError:
                return .keyсhainError
            case .invalidCustomToken,
                 .customTokenMismatch,
                 .missingAppToken,
                 .userTokenExpired,
                 .invalidUserToken:
                return .tokenError
            case .missingVerificationCode,
                 .invalidVerificationCode,
                 .missingVerificationID,
                 .appVerificationUserInteractionFailure,
                 .invalidVerificationID:
                return .verificationError
            case .appNotAuthorized,
                 .localPlayerNotAuthenticated,
                 .unauthorizedDomain:
                return .authorizationError
            case .operationNotAllowed,
                 .accountExistsWithDifferentCredential,
                 .invalidAPIKey,
                 .userMismatch,
                 .credentialAlreadyInUse,
                 .providerAlreadyLinked,
                 .noSuchProvider,
                 .expiredActionCode,
                 .invalidActionCode,
                 .invalidMessagePayload,
                 .invalidSender,
                 .invalidRecipientEmail,
                 .missingEmail,
                 .missingIosBundleID,
                 .missingAndroidPackageName,
                 .invalidContinueURI,
                 .missingContinueURI,
                 .missingPhoneNumber,
                 .invalidPhoneNumber,
                 .missingAppCredential,
                 .invalidAppCredential,
                 .sessionExpired,
                 .quotaExceeded,
                 .notificationNotForwarded,
                 .appNotVerified,
                 .captchaCheckFailed,
                 .webContextAlreadyPresented,
                 .webContextCancelled,
                 .invalidClientID,
                 .webNetworkRequestFailed,
                 .webInternalError,
                 .webSignInUserInteractionFailure,
                 .nullUser,
                 .dynamicLinkNotActivated,
                 .invalidProviderID,
                 .tenantIDMismatch,
                 .unsupportedTenantOperation,
                 .invalidDynamicLinkDomain,
                 .rejectedCredential,
                 .gameKitNotLinked,
                 .secondFactorRequired,
                 .missingMultiFactorSession,
                 .missingMultiFactorInfo,
                 .invalidMultiFactorSession,
                 .multiFactorInfoNotFound,
                 .adminRestrictedOperation,
                 .unverifiedEmail,
                 .secondFactorAlreadyEnrolled,
                 .maximumSecondFactorCountExceeded,
                 .unsupportedFirstFactor,
                 .emailChangeNeedsVerification,
                 .missingOrInvalidNonce,
                 .missingClientIdentifier,
                 .malformedJWT,
                 .blockingCloudFunctionError,
                 .recaptchaNotEnabled,
                 .missingRecaptchaToken,
                 .invalidRecaptchaToken,
                 .invalidRecaptchaAction,
                 .missingClientType,
                 .missingRecaptchaVersion,
                 .invalidRecaptchaVersion,
                 .invalidReqType,
                 .recaptchaSDKNotLinked:
                return .applicationError
        }
    }
}
