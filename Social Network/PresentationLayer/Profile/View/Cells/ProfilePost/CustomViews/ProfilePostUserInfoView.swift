//
//  ProfilePostUserInfoView.swift
//  Social_Network
//
//  Created by Arthur Raff on 09.10.2023.
//

import Foundation
import UIKit

final class ProfilePostUserInfoView: UIView {
    private lazy var userPhotoImage: UIImageView = {
        var iv = UIImageView()
        iv.isUserInteractionEnabled = true
        iv.image = UIImage(systemName: "photo.circle")
        iv.backgroundColor = .systemGray3
        iv.tintColor = .systemGray6
        iv.clipsToBounds = true
        
        return iv
    }()
    
    private lazy var userNameLabel: UILabel = {
        var label = UILabel()
        label.font = .SocialNetworkFont.subhead
        label.textAlignment = .left
        label.text = "Name Surname"
        label.textColor = .SocialNetworkColor.primaryText
        
        return label
    }()
    
    private lazy var userRegaliaLabel: UILabel = {
        var label = UILabel()
        label.font = .SocialNetworkFont.caption2
        label.textAlignment = .left
        label.textColor = .SocialNetworkColor.secondaryText
        label.text = .localized(key: .statusPlaceholder)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var userPostMenuButton: UIButton = {
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
        
        userPhotoImage.layer.cornerRadius = userPhotoImage.frame.height / 2
    }
}

extension ProfilePostUserInfoView {
    func configurePostUserInfo(name: String, regalia: String) {
        userNameLabel.text = name
        userRegaliaLabel.text = regalia
    }
}

private extension ProfilePostUserInfoView {
    func setupView() {
        setupLayout()
        setupContent()
        setupUserPostButtonMenu()
    }
    
    func setupLayout() {
        add(subviews: [userPhotoImage,
                       userNameLabel,
                       userRegaliaLabel,
                       userPostMenuButton])
        
        userPhotoImage.snp.makeConstraints { make in
            make.size.equalTo(32)
            make.top.leading.bottom.equalToSuperview()
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(userPhotoImage.snp.trailing).offset(8)
        }
        
        userRegaliaLabel.snp.makeConstraints { make in
            make.leading.equalTo(userPhotoImage.snp.trailing).offset(8)
            make.top.equalTo(userNameLabel.snp.bottom)
            make.centerX.equalTo(userNameLabel)
        }
        
        userPostMenuButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    func setupContent() {
        backgroundColor = .SocialNetworkColor.clearBackground
        
        userPhotoImage.layer.cornerRadius = userPhotoImage.frame.height / 2
    }
    
    func setupUserPostButtonMenu() {
        let postMenu = UIMenu(children: [
            UIAction(title: "Редактировать", image: UIImage(systemName: "square.and.pencil")) {_ in },
            UIAction(title: "Архивировать", image: UIImage(systemName: "archivebox")) {_ in },
            UIAction(title: "Закрепить", image: UIImage(systemName: "pin")) {_ in },
            UIAction(title: "Удалить запись", image: UIImage(systemName: "trash"), attributes: .destructive) {_ in }
        ])
        
        userPostMenuButton.showsMenuAsPrimaryAction = true
        userPostMenuButton.menu = postMenu
    }
}
