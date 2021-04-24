//
//  AuthErrors.swift
//  Social_Network
//
//  Created by Arthur Raff on 28.03.2021.
//

import UIKit

enum AuthErrors: Error {
    case incorrectData
    case emptyFields
    case unknownError
}

func authErrorHandler(error: AuthErrors, vc: UIViewController) {
    switch error {
    case .incorrectData:
        ErrorsAlert.showErrorsAlert(title: "Ошибка в в данных",
                                    message: "Некорректо введен логин и/или пароль, повторите попытку",
                                    on: vc)
    case .emptyFields:
        ErrorsAlert.showErrorsAlert(title: "Нет данных",
                                    message: "Логин и/или пароль отсутствуют, введите недостающие данные",
                                    on: vc)
    case .unknownError:
        ErrorsAlert.showErrorsAlert(title: "Ой!",
                                    message: "Еноты перегрызли провода, подождите немного и мы все исправим",
                                    on: vc)
    }
}
