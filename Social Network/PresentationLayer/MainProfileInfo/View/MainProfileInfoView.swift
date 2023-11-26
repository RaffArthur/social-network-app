//
//  MainProfileInfoView.swift
//  Social_Network
//
//  Created by Arthur Raff on 15.10.2023.
//

import Foundation
import UIKit

final class MainProfileInfoView: UIView {
    weak var delegate: MainProfileInfoViewDelegate?
    
    var userBirthDate: String? = String()
    
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
        tf.attributedPlaceholder = NSAttributedString(string: .localized(key: .mainProfileInfoNameTitle),
                                                      attributes: [.foregroundColor: UIColor.SocialNetworkColor.placeholderText])
        tf.tintColor = .SocialNetworkColor.accent
        tf.textColor = .SocialNetworkColor.primaryText
        tf.textAlignment = .left
        tf.leftView = UIView(frame: CGRect(x: 0,
                                           y: 0,
                                           width: 10,
                                           height: tf.frame.height))
        tf.leftViewMode = .always
        tf.layer.cornerRadius = 10
        tf.layer.masksToBounds = true
        
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
        tf.attributedPlaceholder = NSAttributedString(string: .localized(key: .mainProfileInfoSurnameTitle),
                                                      attributes: [.foregroundColor: UIColor.SocialNetworkColor.placeholderText])
        tf.tintColor = .SocialNetworkColor.accent
        tf.textColor = .SocialNetworkColor.primaryText
        tf.textAlignment = .left
        tf.leftView = UIView(frame: CGRect(x: 0,
                                           y: 0,
                                           width: 10,
                                           height: tf.frame.height))
        tf.leftViewMode = .always
        tf.layer.cornerRadius = 10
        tf.layer.masksToBounds = true
        
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
        button.tintColor = .SocialNetworkColor.primaryBackground
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
        button.tintColor = .SocialNetworkColor.primaryBackground
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
    
    private lazy var datePicker: UIDatePicker = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"

        let dp = UIDatePicker()
        dp.maximumDate = dateFormatter.date(from: "2008/01/01")
        dp.preferredDatePickerStyle = .wheels
        dp.datePickerMode = .date
        
        return dp
    }()
    
    private lazy var userBirthDateField: UITextField = {
        var tf = UITextField()
        tf.contentVerticalAlignment = .center
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.backgroundColor = .SocialNetworkColor.formBackground
        tf.font = .SocialNetworkFont.text
        tf.attributedPlaceholder = NSAttributedString(string: "01.01.1900",
                                                      attributes: [.foregroundColor: UIColor.SocialNetworkColor.placeholderText])
        tf.tintColor = .SocialNetworkColor.accent
        tf.textColor = .SocialNetworkColor.primaryText
        tf.textAlignment = .left
        tf.leftView = UIView(frame: CGRect(x: 0,
                                           y: 0,
                                           width: 10,
                                           height: tf.frame.height))
        tf.leftViewMode = .always
        tf.layer.cornerRadius = 10
        tf.layer.masksToBounds = true
        tf.inputView = datePicker
        
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
        tf.attributedPlaceholder = NSAttributedString(string: .localized(key: .mainProfileInfoHometownTitle),
                                                      attributes: [.foregroundColor: UIColor.SocialNetworkColor.placeholderText])
        tf.tintColor = .SocialNetworkColor.accent
        tf.textColor = .SocialNetworkColor.primaryText
        tf.textAlignment = .left
        tf.leftView = UIView(frame: CGRect(x: 0,
                                           y: 0,
                                           width: 10,
                                           height: tf.frame.height))
        tf.leftViewMode = .always
        tf.layer.cornerRadius = 10
        tf.layer.masksToBounds = true
        
        return tf
    }()
    
    private lazy var userRegaliaTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .SocialNetworkFont.caption2
        label.textColor = .SocialNetworkColor.primaryText
        label.text = .localized(key: .mainProfileInfoRegaliaTitle)
        
        return label
    }()
    
    private lazy var userRegaliaField: UITextField = {
        var tf = UITextField()
        tf.contentVerticalAlignment = .center
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.textContentType = .addressCity
        tf.backgroundColor = .SocialNetworkColor.formBackground
        tf.font = .SocialNetworkFont.text
        tf.attributedPlaceholder = NSAttributedString(string: .localized(key: .mainProfileInfoRegaliaTitle),
                                                      attributes: [.foregroundColor: UIColor.SocialNetworkColor.placeholderText])
        tf.tintColor = .SocialNetworkColor.accent
        tf.textColor = .SocialNetworkColor.primaryText
        tf.textAlignment = .left
        tf.leftView = UIView(frame: CGRect(x: 0,
                                           y: 0,
                                           width: 10,
                                           height: tf.frame.height))
        tf.leftViewMode = .always
        tf.layer.cornerRadius = 10
        tf.layer.masksToBounds = true
        
        return tf
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupActions()
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
                       userHometownField,
                       userRegaliaTitleLabel,
                       userRegaliaField])
        
        userNameTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview {
                $0.safeAreaLayoutGuide
            }
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
            make.trailing.equalToSuperview().offset(-16)
        }
        
        userFemaleButton.snp.makeConstraints { make in
            make.top.equalTo(userMaleButton.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
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
        }
        
        userRegaliaTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(userHometownField.snp.bottom).offset(14)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        userRegaliaField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(userRegaliaTitleLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    func setupContent() {
        backgroundColor = .SocialNetworkColor.mainBackground
    }
}

private extension MainProfileInfoView {
    @objc func genderSelect(sender: UIButton) {
        if sender == userMaleButton {
            userMaleButton.isSelected = true
            userFemaleButton.isSelected = false
        } else {
            userMaleButton.isSelected = false
            userFemaleButton.isSelected = true
        }
    }
    
    @objc func userBirthDateChanged(sender: UIDatePicker) {
        delegate?.birthDateWillBeSaved(date: sender.date)
        
        userBirthDateField.text = userBirthDate
    }
    
    func setupActions() {
        datePicker.addTarget(self, action: #selector(userBirthDateChanged), for: .valueChanged)
        userMaleButton.addTarget(self, action: #selector(genderSelect(sender:)), for: .touchUpInside)
        userFemaleButton.addTarget(self, action: #selector(genderSelect(sender:)), for: .touchUpInside)
    }
}

extension MainProfileInfoView {
    func getUserMainInfo() -> UserData {
        guard let userName = userNameField.text,
              let userSurname = userSurnameField.text,
              let userRegalia = userRegaliaField.text,
              let maleGender = userMaleButton.titleLabel?.text,
              let femaleGender = userFemaleButton.titleLabel?.text
        else {
            return UserData(userID: nil,
                            name: nil,
                            surname: nil,
                            nickname: nil,
                            regalia: nil,
                            hometown: nil,
                            birthDate: nil,
                            gender: nil,
                            isGenderSelected: nil)
        }
        
        var selectedGender = String()
        var isGenderSelected = false
        
        if userMaleButton.isSelected {
            isGenderSelected = true
            selectedGender = maleGender
        }
        
        if userFemaleButton.isSelected {
            isGenderSelected = true
            selectedGender = femaleGender
        }
        
        return UserData(userID: nil,
                        name: userNameField.text,
                        surname: userSurnameField.text,
                        nickname: "@\(userName)_\(userSurname)".lowercased(),
                        regalia: userRegalia,
                        hometown: userHometownField.text,
                        birthDate: userBirthDateField.text,
                        gender: selectedGender,
                        isGenderSelected: isGenderSelected)
    }
    
    func setupUserMainInfoFields(userName: String,
                                 userSurname: String,
                                 userRegalia: String,
                                 userBirthDate: String,
                                 userHometown: String,
                                 userGender: String) {
        
        userNameField.text = userName
        userSurnameField.text = userSurname
        userBirthDateField.text = userBirthDate
        userRegaliaField.text = userRegalia
        userHometownField.text = userHometown
        
        let maleGender = userMaleButton.titleLabel?.text
        let femaleGender = userFemaleButton.titleLabel?.text
        
        if userGender == maleGender {
            userMaleButton.isSelected = true
            userFemaleButton.isSelected = false
        } 
        
        if userGender == femaleGender {
            userMaleButton.isSelected = false
            userFemaleButton.isSelected = true
        }
    }
}

extension MainProfileInfoView {
    func textField(delegate: UITextFieldDelegate) {
        userNameField.delegate = delegate
        userSurnameField.delegate = delegate
        userBirthDateField.delegate = delegate
        userHometownField.delegate = delegate
        userRegaliaField.delegate = delegate
    }
}
