//
//  LogInViewController.swift
//  Navigation
//

import UIKit

@available(iOS 13.0, *)
class LogInViewController: UIViewController {
    
// MARK: - Properties
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.toAutoLayout()
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    private lazy var contentView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        
        return view
    }()
    private lazy var logoImage: UIImageView = {
        let logoImage = UIImageView(image: #imageLiteral(resourceName: "vk_logo"))
        logoImage.contentMode = .scaleAspectFit
        logoImage.toAutoLayout()
        
        return logoImage
    }()
    private lazy var loginContainer: UIView = {
        let loginContainer = UIView()
        loginContainer.toAutoLayout()
        loginContainer.layer.borderWidth = 0.5
        loginContainer.layer.cornerRadius = 10
        loginContainer.layer.borderColor = UIColor.lightGray.cgColor
        loginContainer.layer.masksToBounds = true

        return loginContainer
    }()
    private lazy var contactsField: UITextField = {
        let contactsField = UITextField()
        contactsField.toAutoLayout()
        contactsField.clearButtonMode = .whileEditing
        contactsField.contentVerticalAlignment = .center
        contactsField.autocorrectionType = .no
        contactsField.autocapitalizationType = .none
        contactsField.isUserInteractionEnabled = true
        contactsField.clearsOnBeginEditing = true
        contactsField.backgroundColor = .systemGray6
        contactsField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        contactsField.placeholder = "Email or phone"
        contactsField.tintColor = UIColor(named: "color_set")
        contactsField.textColor = .black
        contactsField.textAlignment = .left
        contactsField.leftView = UIView(frame: CGRect(
                                            x: 0,
                                            y: 0,
                                            width: 10,
                                            height: contactsField.frame.height))
        contactsField.leftViewMode = .always
        contactsField.layer.borderWidth = 0.5
        contactsField.layer.borderColor = UIColor.lightGray.cgColor
        
        return contactsField
    }()
    private lazy var passwordField: UITextField = {
        var passwordField = UITextField()
        passwordField.toAutoLayout()
        passwordField.clearButtonMode = .whileEditing
        passwordField.contentVerticalAlignment = .center
        passwordField.autocorrectionType = .no
        passwordField.autocapitalizationType = .none
        passwordField.isSecureTextEntry = true
        passwordField.isUserInteractionEnabled = true
        passwordField.clearsOnBeginEditing = true
        passwordField.backgroundColor = .systemGray6
        passwordField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        passwordField.placeholder = "Password"
        passwordField.tintColor = UIColor(named: "color_set")
        passwordField.textColor = .black
        passwordField.textAlignment = .left
        passwordField.leftView = UIView(frame: CGRect(
                                            x: 0,
                                            y: 0,
                                            width: 10,
                                            height: passwordField.frame.height))
        passwordField.leftViewMode = .always
        
        return passwordField
    }()
    private lazy var loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.toAutoLayout()
        loginButton.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(1.0), for: .normal)
        loginButton.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .selected)
        loginButton.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .highlighted)
        loginButton.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .disabled)
        loginButton.setTitle("Log in", for: loginButton.state)
        loginButton.setTitleColor(.white, for: loginButton.state)
        loginButton.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 10
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        return loginButton
    }()

// MARK: - View Funcs
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(logoImage)
        contentView.addSubview(loginContainer)
        contentView.addSubview(loginButton)
        
        loginContainer.addSubview(contactsField)
        loginContainer.addSubview(passwordField)
        
        let loginViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 120),
            logoImage.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor),
            
            loginContainer.heightAnchor.constraint(equalToConstant: 100),
            loginContainer.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            loginContainer.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            loginContainer.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 120),
            
            contactsField.heightAnchor.constraint(equalToConstant: 50),
            contactsField.topAnchor.constraint(equalTo: loginContainer.topAnchor),
            contactsField.leadingAnchor.constraint(equalTo: loginContainer.leadingAnchor),
            contactsField.trailingAnchor.constraint(equalTo: loginContainer.trailingAnchor),
            contactsField.bottomAnchor.constraint(equalTo: passwordField.topAnchor),

            passwordField.heightAnchor.constraint(equalToConstant: 50),
            passwordField.topAnchor.constraint(equalTo: contactsField.bottomAnchor),
            passwordField.leadingAnchor.constraint(equalTo: loginContainer.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: loginContainer.trailingAnchor),
            passwordField.bottomAnchor.constraint(equalTo: loginContainer.bottomAnchor),
            
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            loginButton.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            loginButton.topAnchor.constraint(equalTo: loginContainer.bottomAnchor, constant: 16),
            loginButton.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(loginViewConstraints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white

        setupLayout()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
// MARK: - @objc Actions
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print(keyboardSize)
            print(scrollView.frame.size)
            scrollView.contentInset.bottom = keyboardSize.width
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.width, right: 0)
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    @objc private func loginButtonTapped() {
        
        let alertController = UIAlertController(
            title: "Некорректные данные",
            message: "Данные введены неверно или отсутствуют",
            preferredStyle: .alert
        )
        let alertAction = UIAlertAction(
            title: "Ок",
            style: .cancel,
            handler: .none
        )
        alertController.addAction(alertAction)
        
        guard contactsField.hasText && passwordField.hasText else {
            return self.present(alertController, animated: true, completion: nil)
        }
        
        self.navigationController?.pushViewController(TabBarViewController(), animated: true)
    }
}

// MARK: - Extensions

@available(iOS 13.0, *)
extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }
}

