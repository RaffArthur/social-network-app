//
//  LoginViewController.swift
//  Navigation
//

import FirebaseAuth
import UIKit

@available(iOS 13.0, *)
class LoginViewController: UIViewController {
    weak var delegate: LoginViewControllerDelegate?
    var didSendEventClosure: ((LoginViewController.Event) -> Void)?

    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        
        return sv
    }()
    private lazy var contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    private lazy var logoImage: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "vk_logo"))
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()
    private lazy var loginContainer: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.masksToBounds = true

        return view
    }()
    private lazy var emailField: UITextField = {
        let tf = UITextField()
        tf.clearButtonMode = .whileEditing
        tf.contentVerticalAlignment = .center
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.isUserInteractionEnabled = true
        tf.clearsOnBeginEditing = false
        tf.backgroundColor = .systemGray6
        tf.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        tf.placeholder = "Enter e-mail"
        tf.tintColor = UIColor(named: "color_set")
        tf.textColor = .black
        tf.textAlignment = .left
        tf.leftView = UIView(frame: CGRect(x: 0,
                                           y: 0,
                                           width: 10,
                                           height: tf.frame.height))
        tf.leftViewMode = .always
        tf.layer.borderWidth = 0.5
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.delegate = self
        tf.keyboardType = .emailAddress
        tf.becomeFirstResponder()
        
        return tf
    }()
    private lazy var passwordField: UITextField = {
        var tf = UITextField()
        tf.contentVerticalAlignment = .center
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.isSecureTextEntry = true
        tf.isUserInteractionEnabled = true
        tf.backgroundColor = .systemGray6
        tf.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        tf.placeholder = "Password"
        tf.tintColor = UIColor(named: "color_set")
        tf.textColor = .black
        tf.textAlignment = .left
        tf.delegate = self

        return tf
    }()
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(1.0), for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .selected)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .highlighted)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .disabled)
        button.setTitle("Вход", for: button.state)
        button.setTitleColor(.white, for: button.state)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
        setupActions()
        addKeyboardObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let navigationController = navigationController else { return }
        guard let tabBarController = tabBarController else { return }
        
        navigationController.navigationBar.isHidden = true
        tabBarController.tabBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        removeKeyboardObserver()
    }
}

// MARK: - Extensions
@available(iOS 13.0, *)
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }
}

@available(iOS 13.0, *)
private extension LoginViewController {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.add(subviews: [logoImage,
                                   loginContainer,
                                   loginButton])
        
        loginContainer.add(subviews: [emailField,
                                      passwordField])
                
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
        
        emailField.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(50)
            make.top.equalTo(loginContainer.snp.top)
            make.leading.equalTo(loginContainer.snp.leading)
            make.trailing.equalTo(loginContainer.snp.trailing)
            make.bottom.equalTo(passwordField.snp.top)
        }
        
        passwordField.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(50)
            make.top.equalTo(emailField.snp.bottom)
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
    
    func setupContent() {
        view.backgroundColor = .white
        passwordField.enablePasswordToggle()
    }
}

@available(iOS 13.0, *)
private extension LoginViewController {
    func setupActions() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
}

@available(iOS 13.0, *)
private extension LoginViewController {
    @objc func loginButtonTapped() {
        guard let delegate = delegate else { return }
        guard let email = emailField.text else { return }
        guard let pass = passwordField.text else { return }
        guard let event = didSendEventClosure else { return }
        
        do {
            let _ = try delegate.signIn(vc: self, email: email, pass: pass) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success:
                    event(.userLogged)
                case .failure(let error):
                    authErrorHandler(error: error, vc: self)
                }
            }
        } catch AuthErrors.emptyFields {
            authErrorHandler(error: .emptyFields, vc: self)
        } catch AuthErrors.incorrectData {
            authErrorHandler(error: .incorrectData, vc: self)
        } catch AuthErrors.incorrectEmail{
            authErrorHandler(error: .incorrectEmail, vc: self)
        } catch AuthErrors.incorrectPass{
            authErrorHandler(error: .incorrectPass, vc: self)
        } catch {
            authErrorHandler(error: .unknownError, vc: self)
        }
    }
}

@available(iOS 13.0, *)
private extension LoginViewController {
    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
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
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let insets = UIEdgeInsets(top: 0,
                                      left: 0,
                                      bottom: keyboardSize.width,
                                      right: 0)
            scrollView.contentInset.bottom = keyboardSize.width
            scrollView.verticalScrollIndicatorInsets = insets
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets = .zero
    }
}

@available(iOS 13.0, *)
extension LoginViewController {
    enum Event {
        case userLogged
    }
}
