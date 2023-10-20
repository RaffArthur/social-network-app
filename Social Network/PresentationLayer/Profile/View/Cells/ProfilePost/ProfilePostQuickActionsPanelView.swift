//
//  ProfilePostQuickActionsPanelView.swift
//  Social_Network
//
//  Created by Arthur Raff on 09.10.2023.
//

import Foundation
import UIKit

final class ProfilePostQuickActionsPanelView: UIView {
    weak var delegate: ProfilePostQuickActionsPanelViewDelegate?
    
    private lazy var isPostLiked = false
    private lazy var isPostAddedToFavourite = false
    
    private lazy var postLikesButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .SocialNetworkColor.primaryForeground
        button.tintColor = .SocialNetworkColor.tintIcon
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.tintColor = .SocialNetworkColor.tintIcon
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.setTitle("0", for: .normal)
        button.setTitleColor(.SocialNetworkColor.tintIcon, for: .normal)
        button.titleLabel?.font = .SocialNetworkFont.caption2
        button.titleLabel?.textAlignment = .left
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.contentEdgeInsets = UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10)
        button.sizeToFit()

        return button
    }()
    
    private lazy var postCommentsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .SocialNetworkColor.primaryForeground
        button.tintColor = .SocialNetworkColor.tintIcon
        button.setImage(UIImage(systemName: "message"), for: .normal)
        button.setImage(UIImage(systemName: "message.fill"), for: .selected)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.setTitle("0", for: .normal)
        button.setTitleColor(.SocialNetworkColor.tintIcon, for: .normal)
        button.titleLabel?.font = .SocialNetworkFont.caption2
        button.titleLabel?.textAlignment = .left
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.contentEdgeInsets = UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10)
        button.sizeToFit()

        return button
    }()
    
    private lazy var postAddToFavouritesButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .SocialNetworkColor.primaryForeground
        button.tintColor = .SocialNetworkColor.tintIcon
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.contentEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        button.sizeToFit()
        
        return button
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

private extension ProfilePostQuickActionsPanelView {
    func setupView() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        add(subviews: [postLikesButton,
                       postCommentsButton,
                       postAddToFavouritesButton])
//                       postLikesLabel,
//                       postCommentsLabel])
        
        postLikesButton.snp.makeConstraints { make in
            make.height.equalTo(28)
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        postCommentsButton.snp.makeConstraints { make in
            make.height.equalTo(28)
            make.leading.equalTo(postLikesButton.snp.trailing).offset(8)
            make.centerY.equalTo(postLikesButton)
        }
        
        postAddToFavouritesButton.snp.makeConstraints { make in
            make.height.equalTo(28)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(postLikesButton)
        }
    }
    
    func setupContent() {
        backgroundColor = .SocialNetworkColor.clearBackground
    }
}

private extension ProfilePostQuickActionsPanelView {
    func setupActions() {
        postLikesButton.addTarget(self, action: #selector(postLikesButtonWasTapped(sender: )), for: .touchUpInside)
        postCommentsButton.addTarget(self, action: #selector(postCommentsButtonWasTapped(sender: )), for: .touchUpInside)
        postAddToFavouritesButton.addTarget(self, action: #selector(postAddToFavouritesButtonWasTapped(sender: )), for: .touchUpInside)
    }
    
    @objc func postLikesButtonWasTapped(sender: UIButton) {
        delegate?.postLikesButtonWasTapped(sender: sender)
        
        isPostLiked.toggle()
        
        postLikesButton.isSelected = isPostLiked
        
        if isPostLiked == true {
            postLikesButton.tintColor = .SocialNetworkColor.destructive
        } else {
            postLikesButton.tintColor = .SocialNetworkColor.tintIcon
        }
    }
    
    @objc func postCommentsButtonWasTapped(sender: UIButton) {
        delegate?.postCommentsButtonWasTapped(sender: sender)
    }
    
    @objc func postAddToFavouritesButtonWasTapped(sender: UIButton) {
        delegate?.postAddToFavouritesButtonWasTapped(sender: sender)
        
        isPostAddedToFavourite.toggle()
        
        postAddToFavouritesButton.isSelected = isPostAddedToFavourite
        
        if isPostAddedToFavourite == true {
            postAddToFavouritesButton.tintColor = .SocialNetworkColor.accent
        } else {
            postAddToFavouritesButton.tintColor = .SocialNetworkColor.tintIcon
        }
    }
}

extension ProfilePostQuickActionsPanelView {
    func setupQuiackActionsPanelInfo(postLikes: String,
                                     postComments: String,
                                     isPostLiked: Bool,
                                     isPostAddedToFavourite: Bool) {
//        postLikesLabel.text = postLikes
//        postCommentsLabel.text = postComments
    }
}
