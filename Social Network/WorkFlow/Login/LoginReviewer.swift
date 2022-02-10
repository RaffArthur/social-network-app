//
//  LoginReviewer.swift
//  Social_Network
//
//  Created by Arthur Raff on 09.01.2021.
//

import FirebaseAuth
import UIKit

@available(iOS 13.0, *)
class LoginReviewer: LoginViewControllerDelegate {
    func signOut(completion: @escaping (Result<Any, AuthErrors>) -> Void) throws {
        do {
            completion(.success(true))
            try Auth.auth().signOut()
        } catch {
            completion(.failure(.unknownError))
        }
    }
    
    func signIn(vc: UIViewController,
                email: String,
                pass: String,
                completion: @escaping (Result<Any, AuthErrors>) -> Void) throws {
        guard !email.isEmpty else { throw AuthErrors.emptyFields }
        guard email.isValidEmail() else { throw AuthErrors.incorrectEmail }
        guard !pass.isEmpty else { throw AuthErrors.emptyFields }
        
        Auth.auth().signIn(withEmail: email, password: pass) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if error == nil {
                guard let user = authResult?.user else { return }
                completion(.success(user))
            } else {
                self.showCreateAccount(vc: vc, email: email, pass: pass)
            }
        }
    }
    
    private func showCreateAccount(vc: UIViewController,
                                   email: String,
                                   pass: String) {
        let alert = UIAlertController(title: "Такого аккаунта не существует",
                                      message: "Создайте аккаунт или повторите попытку",
                                      preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Повторить",
                                   style: .cancel)
        let create = UIAlertAction(title: "Создать",
                                   style: .default) { _ in
            Auth.auth().createUser(withEmail: email, password: pass) { authResult, error in
                guard error == nil else { return }
                
                self.accountCreated(vc: vc)
            }
        }

        alert.addAction(cancel)
        alert.addAction(create)

        vc.present(alert, animated: true, completion: nil)
    }
    
    private func accountCreated(vc: UIViewController) {
        let alert = UIAlertController(title: "Аккаунт создан",
                                      message: "Повторно введите свои e-mail и пароль, чтобы войти",
                                      preferredStyle: .alert)
        let cancel = UIAlertAction(title: "ОК",
                                   style: .cancel)
        alert.addAction(cancel)
        
        vc.present(alert, animated: true, completion: nil)
    }
}

