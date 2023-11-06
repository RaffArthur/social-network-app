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
    
    private lazy var postLikesButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .SocialNetworkColor.primaryForeground
        button.tintColor = .SocialNetworkColor.tintIcon
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.tintColor = .SocialNetworkColor.tintIcon
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.setTitleColor(.SocialNetworkColor.tintIcon, for: .normal)
        button.titleLabel?.font = .SocialNetworkFont.caption2
        button.titleLabel?.textAlignment = .left
        button.layer.masksToBounds = true
        button.contentEdgeInsets = UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10)
        button.sizeToFit()

        return button
    }()
    
    private lazy var postCommentsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .SocialNetworkColor.primaryForeground
        button.tintColor = .SocialNetworkColor.tintIcon
        button.setImage(UIImage(systemName: "message"), for: .normal)
        button.setImage(UIImage(systemName: "message.fill"), for: .selected)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.setTitleColor(.SocialNetworkColor.tintIcon, for: .normal)
        button.titleLabel?.font = .SocialNetworkFont.caption2
        button.titleLabel?.textAlignment = .left
        button.layer.masksToBounds = true
        button.contentEdgeInsets = UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10)
        button.sizeToFit()

        return button
    }()
    
    private lazy var postAddToFavouritesButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .SocialNetworkColor.primaryForeground
        button.tintColor = .SocialNetworkColor.tintIcon
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        postLikesButton.layer.cornerRadius = postLikesButton.frame.height / 2
        postCommentsButton.layer.cornerRadius = postCommentsButton.frame.height / 2
        postAddToFavouritesButton.layer.cornerRadius = postAddToFavouritesButton.frame.height / 2
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
        
        postLikesButton.snp.makeConstraints { make in
            make.height.equalTo(28)
            make.top.leading.bottom.equalToSuperview()
        }
        
        postCommentsButton.snp.makeConstraints { make in
            make.height.equalTo(postLikesButton)
            make.leading.equalTo(postLikesButton.snp.trailing).offset(8)
            make.centerY.equalTo(postLikesButton)
        }
        
        postAddToFavouritesButton.snp.makeConstraints { make in
            make.height.equalTo(postLikesButton)
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
        postLikesButton.addTarget(self, action: #selector(postLikesButtonWasTapped), for: .touchUpInside)
        postCommentsButton.addTarget(self, action: #selector(postCommentsButtonWasTapped), for: .touchUpInside)
        postAddToFavouritesButton.addTarget(self, action: #selector(postAddToFavouritesButtonWasTapped), for: .touchUpInside)
    }
    
    @objc func postLikesButtonWasTapped(_ sender: UIButton) {
        delegate?.postLikesButtonWasTappedAt(index: sender.tag)
    }
    
    @objc func postCommentsButtonWasTapped(_ sender: UIButton) {
        delegate?.postCommentsButtonWasTappedAt(index: sender.tag)
    }
    
    @objc func postAddToFavouritesButtonWasTapped(_ sender: UIButton) {
        delegate?.postAddToFavouritesButtonWasTappedAt(index: sender.tag)
    }
}

extension ProfilePostQuickActionsPanelView {
    func configurePostQuickActionsPanelWith(cellIndex: Int,
                                            postLikes: String,
                                            postComments: String,
                                            isPostLiked: Bool,
                                            isPostAddedToFavourite: Bool) {
        
        postLikesButton.tag = cellIndex
        postCommentsButton.tag = cellIndex
        postAddToFavouritesButton.tag = cellIndex
        
        postLikesButton.setTitle(postLikes, for: .normal)
        postCommentsButton.setTitle(postComments, for: .normal)
        
        postLikesButton.isSelected = isPostLiked
        postAddToFavouritesButton.isSelected = isPostAddedToFavourite
        
        
        if postLikesButton.isSelected == true {
            postLikesButton.tintColor = .SocialNetworkColor.likedForeground
            postLikesButton.backgroundColor = .SocialNetworkColor.likedBackground
            postLikesButton.setTitleColor(.SocialNetworkColor.likedText, for: .normal)
        } else {
            postLikesButton.tintColor = .SocialNetworkColor.tintIcon
            postLikesButton.backgroundColor = .SocialNetworkColor.primaryForeground
            postLikesButton.setTitleColor(.SocialNetworkColor.tintIcon, for: .normal)
        }
        
        if postAddToFavouritesButton.isSelected == true {
            postAddToFavouritesButton.tintColor = .SocialNetworkColor.accent
            postAddToFavouritesButton.backgroundColor = .SocialNetworkColor.favouriteBackground
        } else {
            postAddToFavouritesButton.tintColor = .SocialNetworkColor.tintIcon
            postAddToFavouritesButton.backgroundColor = .SocialNetworkColor.primaryForeground
        }
    }
    
    func prepareForReuse() {
        postLikesButton.tintColor = .none
        postLikesButton.backgroundColor = .none
        postLikesButton.setTitleColor(.none, for: .normal)
        postLikesButton.setTitle(.none, for: .normal)
        
        postCommentsButton.setTitle(.none, for: .normal)
        
        postAddToFavouritesButton.tintColor = .none
        postAddToFavouritesButton.backgroundColor = .none
        postAddToFavouritesButton.setTitleColor(.none, for: .normal)
        postAddToFavouritesButton.setTitle(.none, for: .normal)
    }
}
