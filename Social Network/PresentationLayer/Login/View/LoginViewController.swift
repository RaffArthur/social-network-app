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
        
        setupScreen()
    }
}

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
        view.backgroundColor = .systemBackground
    }
}

private extension LoginViewController {    
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
                self?.show(authError: error)
            }
        }
    }
    
    func authTypeButtonWasTapped() {
        delegate?.didUserChooseRegistration()
    }
}
