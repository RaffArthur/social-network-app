//
//  Locilizable+String.swift
//  Social_Network
//
//  Created by Arthur Raff on 07.08.2022.
//

import UIKit

enum SocialNetworkLocalizedStringKeys {
    case profileTab
    case favouriteTab
    case mapTab
    case loginTitle
    case registrationTitle
    case emailPlaceholder
    case passwordPlaceholder
    case repeatPasswordPlaceholder
    case signInButton
    case registrationButton
    case loginTypeLoginTitle
    case loginTypeRegistrationTitle
    case logOutButton
    case statusPlaceholder
    case setUserStatusButton
    case photosTitle
    case postsLikes
    case postsViews
    case favouritesSearchPlaceholder
    case favouritesCounterTitle
    case coordinatesTitle
    case kremlinPinTitle
    case accountCreatedAlertTitle
    case accountCreatedAlertMessage
    case alreadyInFavouritesAlertTitle
    case userStatusAlertTitle
    case userStatusAlertMessage
    case userStatusAlertTextfieldPlaceholder
    case userStatusAlertCancelButton
    case userStatusAlertSetStatusSutton
    case localAuthentificationReason
}

extension SocialNetworkLocalizedStringKeys {
    var localizedStringKey: String {
        switch self {
        case .profileTab:
            return "profile_tab"
        case .favouriteTab:
            return "favourite_tab"
        case .mapTab:
            return "map_tab"
        case .loginTitle:
            return "login_title"
        case .registrationTitle:
            return "registration_title"
        case .emailPlaceholder:
            return "email_placeholder"
        case .passwordPlaceholder:
            return "password_placeholder"
        case .repeatPasswordPlaceholder:
            return "repeat_password_placeholder"
        case .signInButton:
            return "sign_in_button"
        case .registrationButton:
            return "registration_button"
        case .loginTypeLoginTitle:
            return "login_type_login_title"
        case .loginTypeRegistrationTitle:
            return "login_type_registration_title"
        case .logOutButton:
            return "log_out_button"
        case .statusPlaceholder:
            return "status_placeholder"
        case .setUserStatusButton:
            return "set_user_status_button"
        case .photosTitle:
            return "photos_title"
        case .postsLikes:
            return "posts_likes"
        case .postsViews:
            return "posts_views"
        case .favouritesSearchPlaceholder:
            return "favourites_search_placeholder"
        case .favouritesCounterTitle:
            return "favourites_counter_title"
        case .coordinatesTitle:
            return "coordinates_title"
        case .kremlinPinTitle:
            return "kremlin_pin_title"
        case .accountCreatedAlertTitle:
            return "account_created_alert_title"
        case .accountCreatedAlertMessage:
            return "account_created_alert_message"
        case .alreadyInFavouritesAlertTitle:
            return "already_in_favourites_alert_title"
        case .userStatusAlertTitle:
            return "user_status_alert_title"
        case .userStatusAlertMessage:
            return "user_status_alert_message"
        case .userStatusAlertTextfieldPlaceholder:
            return "user_status_alert_textfield_placeholder"
        case .userStatusAlertCancelButton:
            return "user_status_alert_cancel_button"
        case .userStatusAlertSetStatusSutton:
            return "user_status_alert_set_status_button"
        case .localAuthentificationReason:
            return "local_authentification_reason"
        }
    }
}

enum SocialNetworkLocalizedStringDictKeys {
    case postViews
    case postLikes
}

extension SocialNetworkLocalizedStringDictKeys {
    var localizedStringKey: String {
        switch self {
        case .postViews:
            return "post_views"
        case .postLikes:
            return "post_likes"
        }
    }
}

extension String {
    static func localizedPlural(key: SocialNetworkLocalizedStringDictKeys,
                                             argument: Int) -> String {
        let localized = NSLocalizedString(key.localizedStringKey, comment: "nil")
        
        return String(format: localized, argument)
    }
    
    static func localized(key: SocialNetworkLocalizedStringKeys) -> String {
        return NSLocalizedString(key.localizedStringKey, comment: "nil")
    }
}
