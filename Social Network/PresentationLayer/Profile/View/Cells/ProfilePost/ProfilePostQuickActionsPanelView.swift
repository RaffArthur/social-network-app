//
//  ProfilePostQuickActionsPanelView.swift
//  Social_Network
//
//  Created by Arthur Raff on 09.10.2023.
//

import Foundation
import UIKit

final class ProfilePostQuickActionsPanelView: UIView {
    private lazy var postLikesButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .SocialNetworkColor.tintIcon
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        return button
    }()
    
    private lazy var postCommentsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "message"), for: .normal)
        button.tintColor = .SocialNetworkColor.tintIcon
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        return button
    }()
    
    private lazy var postAddToFavouritesButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = .SocialNetworkColor.tintIcon
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        return button
    }()
    
    private lazy var postLikesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .SocialNetworkColor.primaryText
        
        return label
    }()
    
    private lazy var postCommentsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
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

private extension ProfilePostQuickActionsPanelView {
    func setupView() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        add(subviews: [postLikesButton,
                       postCommentsButton,
                       postAddToFavouritesButton,
                       postLikesLabel,
                       postCommentsLabel])
        
        postLikesButton.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        postLikesLabel.snp.makeConstraints { make in
            make.leading.equalTo(postLikesButton.snp.trailing).offset(10)
            make.centerY.equalTo(postLikesButton)
        }
        
        postCommentsButton.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.leading.equalTo(postLikesLabel.snp.trailing).offset(30)
            make.centerY.equalTo(postLikesLabel)
        }
        
        postCommentsLabel.snp.makeConstraints { make in
            make.leading.equalTo(postCommentsButton.snp.trailing).offset(10)
            make.centerY.equalTo(postLikesButton)
        }
        
        postAddToFavouritesButton.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(postLikesButton)
        }
    }
    
    func setupContent() {
        backgroundColor = .SocialNetworkColor.mainBackground

        postLikesLabel.text = String(describing: Int.random(in: 100...500))
        postCommentsLabel.text = String(describing: Int.random(in: 200...1000))
    }
}
