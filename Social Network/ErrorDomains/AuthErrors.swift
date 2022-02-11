//
//  AuthErrors.swift
//  Social_Network
//
//  Created by Arthur Raff on 28.03.2021.
//

import UIKit

enum AuthError: Error {
    case incorrectData
    case incorrectPass
    case incorrectEmail
    case emptyFields
    case unknownError
}

extension AuthError {
    var title: String {
        switch self {
        case .incorrectData:
            return "Неверный e-mail и/или пароль"
        case .incorrectPass:
            return "Неправильный пароль"
        case .incorrectEmail:
            return "Неправильный e-mail"
        case .emptyFields:
            return "Введите свои данные"
        case .unknownError:
            return "ОЙ!"
        }
    }
    
    var message: String {
        switch self {
        case .incorrectData:
            return "Повторите попытку и введите корретный e-mail и пароль"
        case .incorrectPass:
            return "Введен неверный пароль, убедитесь в правильности введенного пароля"
        case .incorrectEmail:
            return "Введен неверный e-mail, убедитесь в правильности введенного e-mail"
        case .emptyFields:
            return "Логин и/или пароль отсутствуют, введите недостающие данные"
        case .unknownError:
            return "Еноты перегрызли провода, подождите немного и мы все исправим"
        }
    }
}
