//
//  ApiErrors.swift
//  Social_Network
//
//  Created by Arthur Raff on 28.03.2021.
//

import UIKit

enum ApiErrors: Error {
    case dataNotFound
    case serverError
    case loadingError
    case unknownError
}

func apiErrorHandler(error: ApiErrors, vc: UIViewController) {
    switch error {
    case .dataNotFound:
        ErrorsAlert.showErrorsAlert(title: "Ошибка данных", message: "К сожалению, мы не смогли найти данные, повторите попытку позднее", on: vc)
    case .loadingError:
        ErrorsAlert.showErrorsAlert(title: "Ошибка загрузки", message: "Мы получили данные, но не смогли их загрузить, повторите попытку позднее", on: vc)
    case .serverError:
        ErrorsAlert.showErrorsAlert(title: "Ошибка сервера", message: "Похоже, что на сервере что-то пошло не так, но мы скоро все исправим", on: vc)
    case .unknownError:
        ErrorsAlert.showErrorsAlert(title: "Неизвестная ошибка", message: "Происходит что-о странное, чего не знаем даже мы! Подождите пока мы разберемся", on: vc)
    }
}
