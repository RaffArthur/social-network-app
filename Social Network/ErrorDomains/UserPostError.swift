//
//  UserPostError.swift
//  Social_Network
//
//  Created by Arthur Raff on 28.10.2023.
//

import Foundation

enum UserPostError: Error {
    case emptyBody
    case unknownError
}

extension UserPostError {
    var title: String {
        switch self {
        case .emptyBody:
            return "Введите текст"
        case .unknownError:
            return "Неизвестная ошибка"
        }
    }
    
    var message: String {
        switch self {
        case .emptyBody:
            return "Добавьте хотя бы какой-то текст, чтобы опубликовать пост"
        case .unknownError:
            return "Еноты перегрызли провода, подождите немного и мы все исправим"
        }
    }
}
