//
//  AuthErrors.swift
//  Social_Network
//
//  Created by Arthur Raff on 28.03.2021.
//

import UIKit
import FirebaseAuth

enum UserAuthError: Error {
    case incorrectData
    case wrongPassword
    case invalidEmail
    case tooManyRequests
    case emptyFields
    case userNotFound
    case unknownError
    case passwordMissmatch
    case weakPassword
    case emailAlreadyInUse
    case invalidCredential
    case requiresRecentLogin
    case userDisabled
    case networkError
    case internalError
    case tokenError
    case verificationError
    case authorizationError
    case applicationError
}

extension UserAuthError {
    var title: String {
        switch self {
        case .incorrectData:
            return "Неверный e-mail и/или пароль"
        case .wrongPassword:
            return "Неправильный пароль"
        case .invalidEmail:
            return "Некорректный e-mail"
        case .emptyFields:
            return "Введите свои данные"
        case .unknownError:
            return "Неизвестная ошибка"
        case .tooManyRequests:
            return "Слишком частые запросы"
        case .userNotFound:
            return "Пользователь не найден"
        case .emailAlreadyInUse:
            return "Введите другой e-mail"
        case .weakPassword:
            return "Ненадежный пароль"
        case .passwordMissmatch:
            return "Пароли не совпадают"
        case .invalidCredential:
            return "Учетные данные недействительны"
        case .userDisabled:
            return "Учетная запись отключена"
        case .requiresRecentLogin:
            return "Требуется выполнить повторный вход"
        case .networkError:
            return "Сетевая ошибка"
        case .internalError:
            return "Возникла внутренняя ошибка"
        case .tokenError:
            return "Ошибка токена"
        case .verificationError:
            return "Ошибка верификации"
        case .authorizationError:
            return "Ошибка авторизации"
        case .applicationError:
            return "Application Error"
        }
    }
    
    var message: String {
        switch self {
        case .incorrectData:
            return "Повторите попытку и введите корретный e-mail и пароль"
        case .wrongPassword:
            return "Введен неверный пароль, убедитесь в правильности введенного пароля"
        case .invalidEmail:
            return "Введите e-mail в корректном формате и повторие попытку"
        case .emptyFields:
            return "Логин и/или пароль отсутствуют, введите недостающие данные"
        case .unknownError:
            return "Еноты перегрызли провода, подождите немного и мы все исправим"
        case .tooManyRequests:
            return "Вход в аккаунт временно недоступен из-за частых попыток авторизации"
        case .userNotFound:
            return "Пользователь с таким e-mail не зарегистрирован или был удален"
        case .emailAlreadyInUse:
            return "Аккаунт с таким e-mail уже существует. Введите новый e-mail и повторите попытку."
        case .weakPassword:
            return "Ваш пароль ненадежный. Введите пароль состоящий минимум из 6 символов"
        case .passwordMissmatch:
            return "Проверьте корректность введенного пароля"
        case .networkError:
            return "Возникла сетевая ошибка"
        case .invalidCredential:
            return "Учетная запись недействительна"
        case .userDisabled:
            return "Учетная запись была отключена и/или удалена"
        case .internalError:
            return "Произошла внутренняя ошибка, мы уже работаем над ее устранением"
        case .applicationError,
             .requiresRecentLogin,
             .tokenError,
             .verificationError,
             .authorizationError:
            return localizedDescription
        }
    }
}
