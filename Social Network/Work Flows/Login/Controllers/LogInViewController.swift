//
//  LogInViewController.swift
//  Navigation
//

import UIKit

@available(iOS 13.0, *)
class LogInViewController: UIViewController {
    
// MARK: - Properties
    weak var delegate: LoginViewControllerDelegate?
    weak var coordinator: ProfileCoordinator?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    private lazy var contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    private lazy var logoImage: UIImageView = {
        let logoImage = UIImageView(image: #imageLiteral(resourceName: "vk_logo"))
        logoImage.contentMode = .scaleAspectFit
        
        return logoImage
    }()
    private lazy var loginContainer: UIView = {
        let loginContainer = UIView()
        loginContainer.layer.borderWidth = 0.5
        loginContainer.layer.cornerRadius = 10
        loginContainer.layer.borderColor = UIColor.lightGray.cgColor
        loginContainer.layer.masksToBounds = true

        return loginContainer
    }()
    lazy var contactsField: UITextField = {
        let contactsField = UITextField()
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
    lazy var passwordField: UITextField = {
        var passwordField = UITextField()
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
        
        scrollView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        contentView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(scrollView.snp.width)
            make.top.equalTo(scrollView.snp.top)
            make.leading.equalTo(scrollView.snp.leading)
            make.trailing.equalTo(scrollView.snp.trailing)
            make.bottom.equalTo(scrollView.snp.bottom)
        }
        
        logoImage.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(120)
            make.centerX.equalTo(contentView.safeAreaLayoutGuide.snp.centerX)
        }
        
        loginContainer.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(100)
            make.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.top.equalTo(logoImage.snp.bottom).offset(120)
        }
        
        contactsField.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(50)
            make.top.equalTo(loginContainer.snp.top)
            make.leading.equalTo(loginContainer.snp.leading)
            make.trailing.equalTo(loginContainer.snp.trailing)
            make.bottom.equalTo(passwordField.snp.top)
        }
        
        passwordField.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(50)
            make.top.equalTo(contactsField.snp.bottom)
            make.leading.equalTo(loginContainer.snp.leading)
            make.trailing.equalTo(loginContainer.snp.trailing)
            make.bottom.equalTo(loginContainer.snp.bottom)
        }
        
        loginButton.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(50)
            make.top.equalTo(loginContainer.snp.bottom).offset(16)
            make.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        navigationController?.tabBarController?.tabBar.isHidden = true
        
        setupLayout()
        addKeyboardObserver()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        removeKeyboardObserver()
    }
    
// MARK: - Custom Funcs
    private func auth() throws -> Bool {
        guard let delegate = delegate else {
            throw AuthErrors.unknownError
        }
        
        guard let filledLogin = contactsField.text, !filledLogin.isEmpty else {
            throw AuthErrors.emptyFields
        }
        
        guard let filledPass = passwordField.text, !filledPass.isEmpty else {
            throw AuthErrors.emptyFields
        }
        
        try delegate.loginWillBeChecked(filledLogin, vc: self, completion: { isLoginCorrect in
            if isLoginCorrect {
                try delegate.passWillBeChecked(filledPass, vc: self, completion: { isPassCorrect in
                    if !isPassCorrect {
                        throw AuthErrors.incorrectData
                    }
                })
            } else {
                throw AuthErrors.incorrectData
            }
        })
        
        return true
    }
    
    private func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
// MARK: - @objc Actions
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print(keyboardSize)
            print(scrollView.frame.size)
            let insets = UIEdgeInsets(top: 0,
                                      left: 0,
                                      bottom: keyboardSize.width,
                                      right: 0)
            scrollView.contentInset.bottom = keyboardSize.width
            scrollView.verticalScrollIndicatorInsets = insets
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    @objc private func loginButtonTapped() {
        do {
            let _ = try auth()
            coordinator?.logIn()
            
        } catch AuthErrors.emptyFields {
            authErrorHandler(error: .emptyFields, vc: self)
        } catch AuthErrors.incorrectData {
            authErrorHandler(error: .incorrectData, vc: self)
        } catch {
            authErrorHandler(error: .unknownError, vc: self)
        }
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

