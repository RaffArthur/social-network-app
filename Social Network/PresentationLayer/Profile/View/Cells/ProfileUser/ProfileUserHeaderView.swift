//
//  ProfileUserHeaderView.swift
//  Navigation
//
//  Created by Arthur Raff on 02.10.2020.
//

import UIKit

final class ProfileUserHeaderView: UIView {
    weak var delegate: ProfileHeaderViewDelegate?
    
    private lazy var userInfographicView = ProfileUserInfographicView()
    private lazy var userQuickActionsView = ProfileUserQuickActionsView()
    
    private lazy var userPhoto: UIImageView = {
        var iv = UIImageView()
        iv.isUserInteractionEnabled = true
        iv.image = UIImage(systemName: "photo.circle")
        iv.backgroundColor = .systemGray3
        iv.tintColor = .systemGray6
        iv.layer.masksToBounds = true
        
        return iv
    }()
    
    private lazy var userName: UILabel = {
        var label = UILabel()
        label.font = .SocialNetworkFont.headline
        label.textAlignment = .left
        label.text = "Name Surname"
        label.textColor = .SocialNetworkColor.primaryText
        
        return label
    }()
    
    private lazy var userDescription: UILabel = {
        var label = UILabel()
        label.font = .SocialNetworkFont.caption1
        label.textAlignment = .left
        label.textColor = .SocialNetworkColor.secondaryText
        label.text = .localized(key: .statusPlaceholder)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var userMoreInfoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "exclamationmark.circle.fill"), for: .normal)
        button.tintColor = .SocialNetworkColor.primaryBackground
        button.setTitle("Подробная информация", for: .normal)
        button.setTitleColor(.SocialNetworkColor.primaryText, for: .normal)
        button.titleLabel?.font = .SocialNetworkFont.subhead
        button.titleLabel?.textAlignment = .left
        button.contentHorizontalAlignment = .left
        button.titleLabel?.lineBreakMode = .byClipping
        button.titleEdgeInsets.left = 8
        
        return button
    }()
    
    private lazy var userEditInfoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Редактировать", for: .normal)
        button.titleLabel?.font = .SocialNetworkFont.t3
        button.setTitleColor(UIColor.SocialNetworkColor.primaryForeground.withAlphaComponent(1.0), for: .normal)
        button.setTitleColor(UIColor.SocialNetworkColor.primaryForeground.withAlphaComponent(0.8), for: .selected)
        button.setTitleColor(UIColor.SocialNetworkColor.primaryForeground.withAlphaComponent(0.8), for: .highlighted)
        button.setTitleColor(UIColor.SocialNetworkColor.primaryForeground.withAlphaComponent(0.8), for: .disabled)
        button.titleLabel?.font = .SocialNetworkFont.t3
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.backgroundColor = .SocialNetworkColor.primaryBackground
        
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
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        
        userPhoto.layer.cornerRadius = userPhoto.frame.height / 2
    }
}

extension ProfileUserHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

extension ProfileUserHeaderView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

private extension ProfileUserHeaderView {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupContent() {
        userPhoto.layer.cornerRadius = userPhoto.frame.height / 2
        
        backgroundColor = .SocialNetworkColor.mainBackground
    }
    
    func setupLayout() {
        add(subviews: [userPhoto,
                       userName,
                       userDescription,
                       userMoreInfoButton,
                       userEditInfoButton,
                       userInfographicView,
                       userQuickActionsView])
        
        userPhoto.snp.makeConstraints { make in
            make.size.equalTo(60)
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        userName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(userPhoto.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        userDescription.snp.makeConstraints { make in
            make.top.equalTo(userName.snp.bottom).offset(4)
            make.leading.equalTo(userPhoto.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        userMoreInfoButton.snp.makeConstraints { make in
            make.top.equalTo(userDescription.snp.bottom).offset(4)
            make.leading.equalTo(userPhoto.snp.trailing).offset(16)
            make.width.equalTo(200)
        }
        
        userEditInfoButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.top.equalTo(userMoreInfoButton.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        userInfographicView.snp.makeConstraints { make in
            make.top.equalTo(userEditInfoButton.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        userQuickActionsView.snp.makeConstraints { make in
            make.top.equalTo(userInfographicView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-24)
        }
    }
}

private extension ProfileUserHeaderView {
    func setupActions() {
        userEditInfoButton.addTarget(self,
                                     action: #selector(userEditInfoButtonTapped),
                                     for: .touchUpInside)
        userMoreInfoButton.addTarget(self,
                                     action: #selector(userMoreInfoButtonTapped),
                                     for: .touchUpInside)

    }
}

private extension ProfileUserHeaderView {
    @objc private func userEditInfoButtonTapped() {
        delegate?.userEditInfoButtonTapped()
    }
    
    @objc private func userMoreInfoButtonTapped() {
        delegate?.userMoreInfoButtonTapped()
    }
}
