//
//  RegistrationView.swift
//  Social_Network
//
//  Created by Arthur Raff on 05.06.2022.
//

import Foundation
import UIKit

final class RegistrationView: UIView {
    weak var delegate: RegistrationViewDelegate?
        
    var userEmail: String? { emailField.text }
    var userPass: String? { passwordField.text }
    var userRepeatPass: String? { repeatPasswordField.text }
    
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
    
    private lazy var registrationTitle: UILabel = {
        let label = UILabel()
        label.text = .setLocalizedStringWith(key: .registrationTitle)
        label.textColor = .SocialNetworkColor.mainText.set()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        
        return label
    }()

    private lazy var registrationContainer: UIStackView = {
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
        tf.placeholder = .setLocalizedStringWith(key: .emailPlaceholder)
        tf.tintColor = .SocialNetworkColor.accent.set()
        tf.textColor = .SocialNetworkColor.mainText.set()
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
        tf.placeholder = .setLocalizedStringWith(key: .passwordPlaceholder)
        tf.tintColor = .SocialNetworkColor.accent.set()
        tf.textColor = .SocialNetworkColor.mainText.set()
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
        tf.placeholder = .setLocalizedStringWith(key: .repeatPasswordPlaceholder)
        tf.tintColor = .SocialNetworkColor.accent.set()
        tf.textColor = .SocialNetworkColor.mainText.set()
        tf.textAlignment = .left
        tf.layer.borderWidth = 0.5
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.delegate = self
        
        return tf
    }()
    
    private lazy var registrationButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(1.0), for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .selected)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .highlighted)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .disabled)
        button.setTitle(.setLocalizedStringWith(key: .registrationButton), for: button.state)
        button.setTitleColor(.white, for: button.state)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    private lazy var registrationTypeTitle: UILabel = {
        let label = UILabel()
        label.text = .setLocalizedStringWith(key: .loginTypeLoginTitle)
        label.textColor = .SocialNetworkColor.secondaryText.set()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        
        return label
    }()
    
    private lazy var authentificationTypeButton: UIButton = {
        let button = UIButton()
        button.setTitle(.setLocalizedStringWith(key: .signInButton), for: button.state)
        button.setTitleColor(UIColor.SocialNetworkColor.accent.set().withAlphaComponent(1.0), for: .normal)
        button.setTitleColor(UIColor.SocialNetworkColor.accent.set().withAlphaComponent(0.8), for: .selected)
        button.setTitleColor(UIColor.SocialNetworkColor.accent.set().withAlphaComponent(0.8), for: .highlighted)
        button.setTitleColor(UIColor.SocialNetworkColor.accent.set().withAlphaComponent(0.8), for: .disabled)
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

private extension RegistrationView {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        addSubview(scrollView)

        scrollView.addSubview(contentView)
        
        contentView.add(subviews: [logoImage,
                                   registrationTitle,
                                   registrationContainer,
                                   registrationButton,
                                   registrationTypeTitle,
                                   authentificationTypeButton])
        
        registrationContainer.add(arrangedSubviews: [emailField,
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
        
        registrationTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImage.snp.bottom).offset(120)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        registrationContainer.snp.makeConstraints { make in
            make.top.equalTo(registrationTitle.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        emailField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        registrationButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(registrationContainer.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        registrationTypeTitle.snp.makeConstraints { make in
            make.top.equalTo(registrationButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        authentificationTypeButton.snp.makeConstraints { make in
            make.top.equalTo(registrationTypeTitle.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(contentView)
        }
    }
    
    func setupContent() {
        passwordField.enablePasswordToggle()
        repeatPasswordField.enablePasswordToggle()
    }
}

private extension RegistrationView {
    @objc func registrationButtonWasTapped() {
        delegate?.registrationButtonWasTapped()
    }
    
    @objc func authentificationTypeButtonWasTapped() {
        delegate?.authTypeButtonWasTapped()
    }
    
    func displayRegistrationForm() {
        registrationTitle.text = "Регистрация аккаунта"
        registrationButton.setTitle("Регистрация", for: .normal)
        authentificationTypeButton.setTitle("Вход", for: .normal)
        registrationTypeTitle.text = "Уже есть аккаунт?"
        repeatPasswordField.isHidden = false
    }
    
    func setupActions() {
        registrationButton.addTarget(self, action: #selector(registrationButtonWasTapped), for: .touchUpInside)
        authentificationTypeButton.addTarget(self, action: #selector(authentificationTypeButtonWasTapped), for: .touchUpInside)
    }
}

extension RegistrationView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }
}
