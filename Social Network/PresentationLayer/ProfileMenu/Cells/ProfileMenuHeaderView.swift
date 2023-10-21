//
//  ProfileMenuHeaderView.swift
//  Social_Network
//
//  Created by Arthur Raff on 21.10.2023.
//

import Foundation
import UIKit

final class ProfileMenuHeaderView: UIView {
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .SocialNetworkFont.headline
        label.textAlignment = .left
        label.text = "Name Surname"
        label.textColor = .SocialNetworkColor.primaryText
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ProfileMenuHeaderView {
    func setupView() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        addSubview(userNameLabel)
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-24)
        }
    }
    
    func setupContent() {
        backgroundColor = .SocialNetworkColor.mainBackground
    }
}

extension ProfileMenuHeaderView {
    func setupUserName(userName: String) {
        userNameLabel.text = userName
    }
}
