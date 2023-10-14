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
        
        setupContent()
    }
    
    override func loadView() {
        view = registrationView
    }
}

private extension RegistrationViewController {
    func setupContent() {
        view.backgroundColor = .SocialNetworkColor.mainBackground
    }
}

private extension RegistrationViewController {
    func accountCreatedAlert() {
        let alert = UIAlertController(title: .localized(key: .accountCreatedAlertTitle),
                                      message: .localized(key: .accountCreatedAlertMessage),
                                      preferredStyle: .alert)
        let cancel = UIAlertAction(title: "ОК",
                                   style: .cancel)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    func show(authErrorAlert: UserAuthError) {
        let alertController = UIAlertController(title: authErrorAlert.title,
                                                message: authErrorAlert.message,
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
                self?.accountCreatedAlert()
                self?.delegate?.didUserRegister()
            case .failure(let error):
                self?.show(authErrorAlert: error)
            }
        }
    }
    
    func authTypeButtonWasTapped() {
        delegate?.didUserChooseLogin()
    }
}
