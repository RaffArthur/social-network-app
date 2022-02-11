//
//  ApiErrors.swift
//  Social_Network
//
//  Created by Arthur Raff on 28.03.2021.
//

import UIKit

enum ApiError: Error {
    case dataNotFound
    case serverError
    case loadingError
    case unknownError
}

extension ApiError {
    var title: String {
        switch self {
        case .dataNotFound:
            return "Ошибка данных"
        case .serverError:
            return "Ошибка загрузки"
        case .loadingError:
            return "Ошибка сервера"
        case .unknownError:
            return "Неизвестная ошибка"
        }
    }
    
    var message: String {
        switch self {
        case .dataNotFound:
            return "К сожалению, мы не смогли найти данные, повторите попытку позднее"
        case .serverError:
            return "Мы получили данные, но не смогли их загрузить, повторите попытку позднее"
        case .loadingError:
            return "Похоже, что на сервере что-то пошло не так, но мы скоро все исправим"
        case .unknownError:
            return "Происходит что-о странное, чего не знаем даже мы! Подождите пока мы разберемся"
        }
    }
}
