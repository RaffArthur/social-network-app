//
//  LoginView.swift
//  Social_Network
//
//  Created by Arthur Raff on 11.02.2022.
//

import UIKit
import Foundation

final class LoginView: UIView {
    weak var delegate: LoginViewDelegate?
        
    var userEmail: String? { emailField.text }
    var userPass: String? { passwordField.text }
    var userRepeatPass: String? { repeatPasswordField.text }
    var isInRegistrationForm: Bool = true {
        didSet {
            isInRegistrationForm ? displayRegistrationForm() : displayLoginForm()
        }
    }
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        sv.automaticallyAdjustsScrollIndicatorInsets = true

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
    
    private lazy var loginTitle: UILabel = {
        let label = UILabel()
        label.text = "Регистрация аккаунта"
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        
        return label
    }()

    private lazy var loginContainer: UIStackView = {
        let sv = UIStackView()
        sv.layer.borderWidth = 0.5
        sv.layer.cornerRadius = 10
        sv.layer.borderColor = UIColor.lightGray.cgColor
        sv.layer.masksToBounds = true
        sv.axis = .vertical
        sv.distribution = .fillEqually

        return sv
    }()
    
    private lazy var emailField: UITextField = {
        let tf = UITextField()
        tf.contentVerticalAlignment = .center
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.clearsOnBeginEditing = false
        tf.backgroundColor = .systemGray6
        tf.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        tf.placeholder = "Введите e-mail"
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
        
        return tf
    }()
    
    private lazy var passwordField: UITextField = {
        var tf = UITextField()
        tf.contentVerticalAlignment = .center
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.isSecureTextEntry = true
        tf.textContentType = .newPassword
        tf.backgroundColor = .systemGray6
        tf.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        tf.placeholder = "Введите пароль"
        tf.tintColor = UIColor(named: "color_set")
        tf.textColor = .black
        tf.textAlignment = .left
        tf.layer.borderWidth = 0.5
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.delegate = self

        return tf
    }()
    
    private lazy var repeatPasswordField: UITextField = {
        var tf = UITextField()
        tf.contentVerticalAlignment = .center
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.isSecureTextEntry = true
        tf.textContentType = .newPassword
        tf.backgroundColor = .systemGray6
        tf.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        tf.placeholder = "Повторите пароль"
        tf.tintColor = UIColor(named: "color_set")
        tf.textColor = .black
        tf.textAlignment = .left
        tf.layer.borderWidth = 0.5
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.delegate = self
        
        return tf
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(1.0), for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .selected)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .highlighted)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .disabled)
        button.setTitle("Регистрация", for: button.state)
        button.setTitleColor(.white, for: button.state)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    private lazy var loginTypeTitle: UILabel = {
        let label = UILabel()
        label.text = "Уже есть аккаунт?"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14, weight: .medium)
        
        return label
    }()
    
    private lazy var loginTypeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: button.state)
        button.setTitleColor(UIColor(named: "color_set")?.withAlphaComponent(1.0), for: .normal)
        button.setTitleColor(UIColor(named: "color_set")?.withAlphaComponent(0.8), for: .selected)
        button.setTitleColor(UIColor(named: "color_set")?.withAlphaComponent(0.8), for: .highlighted)
        button.setTitleColor(UIColor(named: "color_set")?.withAlphaComponent(0.8), for: .disabled)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupScreen()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LoginView {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        addSubview(scrollView)

        scrollView.addSubview(contentView)
        
        contentView.add(subviews: [logoImage,
                                   loginTitle,
                                   loginContainer,
                                   loginButton,
                                   loginTypeTitle,
                                   loginTypeButton])
        
        loginContainer.add(arrangedSubviews: [emailField,
                                              passwordField,
                                              repeatPasswordField])
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView)
            make.top.equalTo(scrollView).offset(120)
            make.leading.trailing.equalTo(scrollView)
            make.bottom.equalTo(scrollView)
        }
        
        logoImage.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.top.equalTo(contentView)
            make.centerX.equalToSuperview()
        }
        
        loginTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImage.snp.bottom).offset(120)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        loginContainer.snp.makeConstraints { make in
            make.top.equalTo(loginTitle.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        emailField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(loginContainer.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        loginTypeTitle.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        loginTypeButton.snp.makeConstraints { make in
            make.top.equalTo(loginTypeTitle.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(contentView)
        }
    }
    
    func setupContent() {
        passwordField.enablePasswordToggle()
        repeatPasswordField.enablePasswordToggle()
    }
}

private extension LoginView {
    @objc func loginButtonWasTapped() {
        isInRegistrationForm ? delegate?.registrationButtonWasTapped() : delegate?.loginButtonWasTapped()
    }
    
    @objc func loginTypeButtonWasTapped() {
        delegate?.loginTypeButtonWasTapped()
    }
    
    func displayRegistrationForm() {
        loginTitle.text = "Регистрация аккаунта"
        loginButton.setTitle("Регистрация", for: .normal)
        loginTypeButton.setTitle("Вход", for: .normal)
        loginTypeTitle.text = "Уже есть аккаунт?"
        repeatPasswordField.isHidden = false
    }
    
    func displayLoginForm() {
        loginTitle.text = "Вход"
        loginButton.setTitle("Вход", for: .normal)
        loginTypeButton.setTitle("Регистрация", for: .normal)
        loginTypeTitle.text = "Нет аккаунта? Тогда пройдите регистрацию"
        repeatPasswordField.isHidden = true
    }
    
    func setupActions() {
        loginButton.addTarget(self, action: #selector(loginButtonWasTapped), for: .touchUpInside)
        loginTypeButton.addTarget(self, action: #selector(loginTypeButtonWasTapped), for: .touchUpInside)
    }
}

extension LoginView {
    func set(contentOffset: CGFloat) {
        if contentOffset != 0 {
            scrollView.contentOffset = CGPoint(x: 0, y: contentOffset)
        } else {
            scrollView.contentOffset = .zero
        }
    }
}

extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }
}
