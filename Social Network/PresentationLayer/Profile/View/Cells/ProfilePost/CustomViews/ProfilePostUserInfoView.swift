//
//  ProfilePostUserInfoView.swift
//  Social_Network
//
//  Created by Arthur Raff on 09.10.2023.
//

import Foundation
import UIKit

final class ProfilePostUserInfoView: UIView {
    private lazy var userPostPhotoImageView: UIImageView = {
        var iv = UIImageView()
        iv.isUserInteractionEnabled = true
        iv.image = UIImage(systemName: "photo.circle")
        iv.backgroundColor = .systemGray3
        iv.tintColor = .systemGray6
        iv.clipsToBounds = true
        
        return iv
    }()
    
    private lazy var userPostNameLabel: UILabel = {
        var label = UILabel()
        label.font = .SocialNetworkFont.subhead
        label.textAlignment = .left
        label.text = "Name Surname"
        label.textColor = .SocialNetworkColor.primaryText
        
        return label
    }()
    
    private lazy var userPostRegaliaLabel: UILabel = {
        var label = UILabel()
        label.font = .SocialNetworkFont.caption2
        label.textAlignment = .left
        label.textColor = .SocialNetworkColor.secondaryText
        label.text = .localized(key: .statusPlaceholder)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var userPostQuickMenuButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .SocialNetworkColor.tintIcon
        button.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .fill
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        userPostPhotoImageView.layer.cornerRadius = userPostPhotoImageView.frame.height / 2
    }
}

extension ProfilePostUserInfoView {
    func configurePostUserInfo(name: String, regalia: String) {
        userPostNameLabel.text = name
        userPostRegaliaLabel.text = regalia
    }
}

private extension ProfilePostUserInfoView {
    func setupView() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        add(subviews: [userPostPhotoImageView,
                       userPostNameLabel,
                       userPostRegaliaLabel,
                       userPostQuickMenuButton])
        
        userPostPhotoImageView.snp.makeConstraints { make in
            make.size.equalTo(32)
            make.top.leading.bottom.equalToSuperview()
        }
        
        userPostNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(userPostPhotoImageView.snp.trailing).offset(8)
        }
        
        userPostRegaliaLabel.snp.makeConstraints { make in
            make.leading.equalTo(userPostPhotoImageView.snp.trailing).offset(8)
            make.top.equalTo(userPostNameLabel.snp.bottom)
            make.centerX.equalTo(userPostNameLabel)
        }
        
        userPostQuickMenuButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    func setupContent() {
        backgroundColor = .SocialNetworkColor.clearBackground
        
        userPostPhotoImageView.layer.cornerRadius = userPostPhotoImageView.frame.height / 2
    }
}
