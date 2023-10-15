//
//  MainProfileInfoView.swift
//  Social_Network
//
//  Created by Arthur Raff on 15.10.2023.
//

import Foundation
import UIKit

final class MainProfileInfoView: UIView {
    private lazy var userNameTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .SocialNetworkFont.caption2
        label.textColor = .SocialNetworkColor.primaryText
        label.text = .localized(key: .mainProfileInfoNameTitle)
        
        return label
    }()
    
    private lazy var userNameField: UITextField = {
        var tf = UITextField()
        tf.contentVerticalAlignment = .center
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.textContentType = .name
        tf.backgroundColor = .SocialNetworkColor.formBackground
        tf.font = .SocialNetworkFont.text
        tf.attributedPlaceholder = NSAttributedString(string: .localized(key: .passwordPlaceholder),
                                                      attributes: [.foregroundColor: UIColor.SocialNetworkColor.placeholderText])
        tf.tintColor = .SocialNetworkColor.accent
        tf.textColor = .SocialNetworkColor.primaryText
        tf.textAlignment = .left
        
        return tf
    }()
    
    private lazy var userSurnameTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .SocialNetworkFont.caption2
        label.textColor = .SocialNetworkColor.primaryText
        label.text = .localized(key: .mainProfileInfoSurnameTitle)
        
        return label
    }()
    
    private lazy var userSurnameField: UITextField = {
        var tf = UITextField()
        tf.contentVerticalAlignment = .center
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.textContentType = .name
        tf.backgroundColor = .SocialNetworkColor.formBackground
        tf.font = .SocialNetworkFont.text
        tf.attributedPlaceholder = NSAttributedString(string: .localized(key: .passwordPlaceholder),
                                                      attributes: [.foregroundColor: UIColor.SocialNetworkColor.placeholderText])
        tf.tintColor = .SocialNetworkColor.accent
        tf.textColor = .SocialNetworkColor.primaryText
        tf.textAlignment = .left
        
        return tf
    }()
    
    private lazy var userGenderTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .SocialNetworkFont.caption2
        label.textColor = .SocialNetworkColor.primaryText
        label.text = .localized(key: .mainProfileInfoGenderTitle)
        
        return label
    }()
    
    private lazy var userMaleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.setImage(UIImage(systemName: "largecircle.fill.circle"), for: .selected)
        button.tintColor = .SocialNetworkColor.primaryForeground
        button.setTitle(.localized(key: .mainProfileInfoMaleButtonTitle), for: .normal)
        button.setTitleColor(.SocialNetworkColor.primaryText, for: .normal)
        button.titleLabel?.font = .SocialNetworkFont.subhead
        button.titleLabel?.textAlignment = .left
        button.contentHorizontalAlignment = .left
        button.titleLabel?.lineBreakMode = .byClipping
        button.titleEdgeInsets.left = 14
        
        return button
    }()
    
    private lazy var userFemaleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.setImage(UIImage(systemName: "largecircle.fill.circle"), for: .selected)
        button.tintColor = .SocialNetworkColor.primaryForeground
        button.setTitle(.localized(key: .mainProfileInfoFemaleButtonTitle), for: .normal)
        button.setTitleColor(.SocialNetworkColor.primaryText, for: .normal)
        button.titleLabel?.font = .SocialNetworkFont.subhead
        button.titleLabel?.textAlignment = .left
        button.contentHorizontalAlignment = .left
        button.titleLabel?.lineBreakMode = .byClipping
        button.titleEdgeInsets.left = 14
        
        return button
    }()
    
    private lazy var userBirthDateTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .SocialNetworkFont.caption2
        label.textColor = .SocialNetworkColor.primaryText
        label.text = .localized(key: .mainProfileInfoBirthDateTitle)
        
        return label
    }()
    
    private lazy var userBirthDateField: UITextField = {
        var tf = UITextField()
        tf.contentVerticalAlignment = .center
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        if #available(iOS 17.0, *) {
            tf.textContentType = .birthdate
        } else {
            // Fallback on earlier versions
        }
        tf.backgroundColor = .SocialNetworkColor.formBackground
        tf.font = .SocialNetworkFont.text
        tf.attributedPlaceholder = NSAttributedString(string: .localized(key: .passwordPlaceholder),
                                                      attributes: [.foregroundColor: UIColor.SocialNetworkColor.placeholderText])
        tf.tintColor = .SocialNetworkColor.accent
        tf.textColor = .SocialNetworkColor.primaryText
        tf.textAlignment = .left
        
        return tf
    }()
    
    private lazy var userHometownTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .SocialNetworkFont.caption2
        label.textColor = .SocialNetworkColor.primaryText
        label.text = .localized(key: .mainProfileInfoHometownTitle)
        
        return label
    }()
    
    private lazy var userHometownField: UITextField = {
        var tf = UITextField()
        tf.contentVerticalAlignment = .center
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.textContentType = .addressCity
        tf.backgroundColor = .SocialNetworkColor.formBackground
        tf.font = .SocialNetworkFont.text
        tf.attributedPlaceholder = NSAttributedString(string: .localized(key: .passwordPlaceholder),
                                                      attributes: [.foregroundColor: UIColor.SocialNetworkColor.placeholderText])
        tf.tintColor = .SocialNetworkColor.accent
        tf.textColor = .SocialNetworkColor.primaryText
        tf.textAlignment = .left
        
        return tf
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MainProfileInfoView {
    func setupView() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        add(subviews: [userNameTitleLabel,
                       userNameField,
                       userSurnameTitleLabel,
                       userSurnameField,
                       userGenderTitleLabel,
                       userMaleButton,
                       userFemaleButton,
                       userBirthDateTitleLabel,
                       userBirthDateField,
                       userHometownTitleLabel,
                       userHometownField])
        
        userNameTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        userNameField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(userNameTitleLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        userSurnameTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameField.snp.bottom).offset(14)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        userSurnameField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(userSurnameTitleLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        userGenderTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(userSurnameField.snp.bottom).offset(14)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        userMaleButton.snp.makeConstraints { make in
            make.top.equalTo(userGenderTitleLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(16)
        }
        
        userFemaleButton.snp.makeConstraints { make in
            make.top.equalTo(userMaleButton.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
        }
        
        userBirthDateTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(userFemaleButton.snp.bottom).offset(14)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        userBirthDateField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(userBirthDateTitleLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        userHometownTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(userBirthDateField.snp.bottom).offset(14)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        userHometownField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(userHometownTitleLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
    }
    
    func setupContent() {
        backgroundColor = .SocialNetworkColor.mainBackground
    }
}
