//
//  RegistrationViewController.swift
//  Social_Network
//
//  Created by Arthur Raff on 05.06.2022.
//

import Foundation
import UIKit
import FirebaseAuth

final class RegistrationViewController: UIViewController {
    weak var reviewer: AuthentificationReviewer?
    weak var delegate: RegistrationViewConrollerDelegate?
    
    private lazy var registrationView = RegistrationView()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        registrationView.delegate = self
        
        setupScreen()
    }
}

private extension RegistrationViewController {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        view.addSubview(registrationView)
                
        registrationView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupContent() {
        view.backgroundColor = .systemBackground
    }
}

private extension RegistrationViewController {
    func accountCreated() {
        let alert = UIAlertController(title: "Аккаунт создан",
                                      message: nil,
                                      preferredStyle: .alert)
        let cancel = UIAlertAction(title: "ОК",
                                   style: .cancel)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    func show(authError: UserAuthError) {
        let alertController = UIAlertController(title: authError.title,
                                                message: authError.message,
                                                preferredStyle: .alert)
        
        let action = UIAlertAction(title: "ОК",
                                   style: .cancel,
                                   handler: nil)
        
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension RegistrationViewController: RegistrationViewDelegate {
    func registrationButtonWasTapped() {
        guard let email = registrationView.userEmail,
              let password = registrationView.userPass,
              let repeatPassword = registrationView.userRepeatPass
        else {
            return
        }
        
        let credentials = UserCredentials(email: email,
                                          password: password,
                                          repeatPassword: repeatPassword,
                                          loggedIn: true)
        
        reviewer?.registrationWith(credentials: credentials) { [weak self] result in
            switch result {
            case .success:
                self?.delegate?.didUserRegister()
            case .failure(let error):
                self?.show(authError: error)
            }
        }
    }
    
    func authTypeButtonWasTapped() {
        delegate?.didUserChooseLogin()
    }
}
