//
//  LoginViewController.swift
//  Navigation
//

import UIKit

import FirebaseAuth

final class LoginViewController: UIViewController {
    weak var reviewer: LoginReviewer?
    weak var delegate: LoginViewConrollerDelegate?
        
    private lazy var loginView = LoginView()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.delegate = self
        
        setupScreen()
    }
}

@available(iOS 13.0, *)
private extension LoginViewController {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        view.addSubview(loginView)
                
        loginView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupContent() {
        view.backgroundColor = .white
    }
}

private extension LoginViewController {
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

extension LoginViewController: LoginViewDelegate {
    func loginButtonWasTapped() {
        guard let email = loginView.userEmail,
              let pass = loginView.userPass
        else {
            return
        }
        
        reviewer?.signIn(email: email, pass: pass) { [weak self] result in
            switch result {
            case .success:
                self?.delegate?.userLoggedIn()
            case .failure(let error):
                self?.show(authError: error)
            }
        }
    }
    
    func registrationButtonWasTapped() {
        guard let email = loginView.userEmail,
              let pass = loginView.userPass,
              let repeatPass = loginView.userRepeatPass
        else {
            return
        }
        
        reviewer?.registration(email: email, pass: pass, repeatPass: repeatPass) { result in
            switch result {
            case .success:
                self.accountCreated()
            case .failure(let error):
                self.show(authError: error)
            }
        }
    }
    
    func loginTypeButtonWasTapped() {
        loginView.isInRegistrationForm = !loginView.isInRegistrationForm
    }
}
