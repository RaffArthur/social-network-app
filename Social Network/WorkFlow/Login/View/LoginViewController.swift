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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addKeyboardObserver()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        removeKeyboardObserver()
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

private extension LoginViewController {
    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)

        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue  else { return }
        
        loginView.set(contentOffset: keyboardSize.height)
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        loginView.set(contentOffset: .zero)
    }
}

extension LoginViewController: LoginViewDelegate {
    func loginButtonWasTapped() {
        guard let email = loginView.userEmail,
              let pass = loginView.userPass
        else {
            return
        }
        
        reviewer?.signIn(email: email, pass: pass) { result in
            switch result {
            case .success:
                self.delegate?.userLoggedIn()
            case .failure(let error):
                self.show(authError: error)
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
