//
//  UserMainProfileInfoError.swift
//  Social_Network
//
//  Created by Arthur Raff on 17.10.2023.
//

import Foundation

enum UserMainProfileInfoError: Error {
    case emptyFields
    case unknownError
}

extension UserMainProfileInfoError {
    var title: String {
        switch self {
        case .emptyFields:
            return "Введите свои данные"
        case .unknownError:
            return "Неизвестная ошибка"
        }
    }
    
    var message: String {
        switch self {
        case .emptyFields:
            return "Заполните все поля и повторите попытку"
        case .unknownError:
            return "Еноты перегрызли провода, подождите немного и мы все исправим"
        }
    }
}
