//
//  LoginViewController.swift
//  Navigation
//

import UIKit
import FirebaseAuth

final class LoginViewController: UIViewController {
    weak var reviewer: AuthentificationReviewer?
    weak var delegate: LoginViewConrollerDelegate?
    
    private lazy var loginView = LoginView()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.delegate = self
        
        setupContent()
    }
    
    override func loadView() {
        view = loginView
    }
}

private extension LoginViewController {
    func setupContent() {
        view.backgroundColor = .systemBackground
    }
}

private extension LoginViewController {    
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

extension LoginViewController: LoginViewDelegate {
    func loginButtonWasTapped() {
        guard let email = loginView.userEmail,
              let password = loginView.userPass
        else {
            return
        }
        
        let credentials = UserCredentials(email: email,
                                          password: password,
                                          repeatPassword: nil,
                                          loggedIn: true)
        
        reviewer?.signInWith(credentials: credentials) { [weak self] result in
            switch result {
            case .success:
                self?.delegate?.didUserLogin()
            case .failure(let error):
                self?.show(authErrorAlert: error)
            }
        }
    }
    
    func authTypeButtonWasTapped() {
        delegate?.didUserChooseRegistration()
    }
}
