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
    case incorrectPass
    case incorrectEmail
    case tooManyRequests
    case emptyFields
    case userNotFound
    case unknownError
    case passwordMissmatch
    case weakPass
    case existingAccount
}

extension UserAuthError {
    var title: String {
        switch self {
        case .incorrectData:
            return "Неверный e-mail и/или пароль"
        case .incorrectPass:
            return "Неправильный пароль"
        case .incorrectEmail:
            return"Некорректный e-mail"
        case .emptyFields:
            return "Введите свои данные"
        case .unknownError:
            return "ОЙ!"
        case .tooManyRequests:
            return "Слишком частые запросы"
        case .userNotFound:
            return "Пользователь не найден"
        case .existingAccount:
            return "Введите другой e-mail"
        case .weakPass:
            return "Ненадежный пароль"
        case .passwordMissmatch:
            return "Пароли не совпадают"
        }
    }
    
    var message: String {
        switch self {
        case .incorrectData:
            return "Повторите попытку и введите корретный e-mail и пароль"
        case .incorrectPass:
            return "Введен неверный пароль, убедитесь в правильности введенного пароля"
        case .incorrectEmail:
            return "Введите e-mail в корректном формате и повторие попытку"
        case .emptyFields:
            return "Логин и/или пароль отсутствуют, введите недостающие данные"
        case .unknownError:
            return "Еноты перегрызли провода, подождите немного и мы все исправим"
        case .tooManyRequests:
            return "Вход временно невозможен, т.к. вы пытались выполнить вход слишком часто"
        case .userNotFound:
            return "Пользователь с таким e-mail не зарегистрирован или был удален"
        case .existingAccount:
            return "Аккаунт с таким e-mail уже существует. Введите новый e-mail и повторите попытку."
        case .weakPass:
            return "Ваш пароль ненадежный. Введите пароль состоящий минимум из 6 символов"
        case .passwordMissmatch:
            return "Проверьте корректность введенного пароля"
        }
    }
}
