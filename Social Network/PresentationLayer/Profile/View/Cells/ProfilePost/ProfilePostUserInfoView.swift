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
        iv.layer.masksToBounds = true
        
        return iv
    }()
    
    private lazy var userPostNameLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .heavy)
        label.textAlignment = .left
        label.text = "Name Surname"
        label.textColor = .SocialNetworkColor.mainText.set()
        
        return label
    }()
    
    private lazy var userPostRegaliaLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        label.textColor = .SocialNetworkColor.secondaryText.set()
        label.text = .localized(key: .statusPlaceholder)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var userPostQuickMenuButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .SocialNetworkColor.accent.set()
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
            make.size.equalTo(60)
            make.top.leading.bottom.equalToSuperview()
        }
        
        userPostNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(userPostPhotoImageView.snp.trailing).offset(24)
        }
        
        userPostRegaliaLabel.snp.makeConstraints { make in
            make.top.equalTo(userPostNameLabel.snp.bottom).offset(4)
            make.leading.equalTo(userPostPhotoImageView.snp.trailing).offset(24)
        }
        
        userPostQuickMenuButton.snp.makeConstraints { make in
            make.width.equalTo(24)
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    func setupContent() {
        backgroundColor = .systemBackground
        
        userPostPhotoImageView.layer.cornerRadius = userPostPhotoImageView.frame.height / 2
    }
}
