//
//  AuthErrors.swift
//  Social_Network
//
//  Created by Arthur Raff on 28.03.2021.
//

import UIKit

enum AuthErrors: Error {
    case incorrectData
    case incorrectPass
    case incorrectEmail
    case emptyFields
    case unknownError
}

func authErrorHandler(error: AuthErrors, vc: UIViewController) {
    switch error {
    case .incorrectData:
        ErrorsAlert.showErrorsAlert(title: "Неверный e-mail и/или пароль",
                                    message: "Повторите попытку и введите корретный e-mail и пароль",
                                    on: vc)
    case .emptyFields:
        ErrorsAlert.showErrorsAlert(title: "Нет данных",
                                    message: "Логин и/или пароль отсутствуют, введите недостающие данные",
                                    on: vc)
    case .unknownError:
        ErrorsAlert.showErrorsAlert(title: "Ой!",
                                    message: "Еноты перегрызли провода, подождите немного и мы все исправим",
                                    on: vc)
    case .incorrectPass:
        ErrorsAlert.showErrorsAlert(title: "Неправильный пароль",
                                    message: "Введен неверный пароль, убедитесь в правильности введенного пароля",
                                    on: vc)
    case .incorrectEmail:
        ErrorsAlert.showErrorsAlert(title: "Неверный e-mail",
                                    message: "Введен неверный e-mail, убедитесь в правильности введенного e-mail",
                                    on: vc)
    }
}
