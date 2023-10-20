//
//  ProfilePostTableViewCell.swift
//  Navigation
//
//  Created by Arthur Raff on 12.10.2020.
//

import Foundation
import UIKit

final class ProfilePostTableViewCell: UITableViewCell {
    weak var delegate: ProfilePostTableViewCellDelegate?
    
    private lazy var postUserInfoView = ProfilePostUserInfoView()
    private lazy var postQuickActionsPanelView = ProfilePostQuickActionsPanelView()
    
    private lazy var postTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .SocialNetworkFont.t3
        label.textColor = .SocialNetworkColor.primaryText
        label.numberOfLines = 2
        label.lineBreakMode = .byClipping
        
        return label
    }()
    
    private lazy var postDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .SocialNetworkFont.text
        label.textColor = .SocialNetworkColor.primaryText
        label.numberOfLines = 0
        
        return label
    }()

    private lazy var postPhoto: UIImageView = {
        let iv = UIImageView()
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 18
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "photo.fill")
        iv.backgroundColor = .SocialNetworkColor.accent
        iv.tintColor = .white
        
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                        
        setupScreen()
        
        postQuickActionsPanelView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ProfilePostTableViewCell {
    func configure(post: Post, userName: String, userRegalia: String) {
        guard let postTitle = post.title,
              let postDescription = post.body,
              let postLikes = post.likes,
              let postComments = post.comments,
              let isPostLiked = post.isPostLiked,
              let isPostAddedToFavourite = post.isPostAddedToFavourite
        else {
            return
        }
        
        postQuickActionsPanelView.setupQuiackActionsPanelInfo(postLikes: postLikes,
                                                              postComments: postComments,
                                                              isPostLiked: isPostLiked,
                                                              isPostAddedToFavourite: isPostAddedToFavourite)
        
        postUserInfoView.setupProfileUserInfo(name: userName,
                                              regalia: userRegalia)
        
        self.postTitleLabel.text = postTitle.firstUppercased
        self.postDescriptionLabel.text = postDescription.firstUppercased
    }
    
    func configure(post: FavouritePost, userName: String, userRegalia: String) {
        guard let postTitle = post.title,
              let postDescription = post.body,
              let postLikes = post.likes,
              let postComments = post.comments
        else {
            return
        }
        
        postQuickActionsPanelView.setupQuiackActionsPanelInfo(postLikes: postLikes,
                                                              postComments: postComments,
                                                              isPostLiked: post.isPostLiked,
                                                              isPostAddedToFavourite: post.isPostAddedToFavurite)
        
        postUserInfoView.setupProfileUserInfo(name: userName, 
                                              regalia: userRegalia)
        
        self.postTitleLabel.text = postTitle.firstUppercased
        self.postDescriptionLabel.text = postDescription.firstUppercased
    }
}

extension ProfilePostTableViewCell: ProfilePostQuickActionsPanelViewDelegate {
    func postLikesButtonWasTapped(sender: UIButton) {
        delegate?.postLikesButtonWasTapped(sender: sender)
    }
    
    func postCommentsButtonWasTapped(sender: UIButton) {
        delegate?.postCommentsButtonWasTapped(sender: sender)
    }
    
    func postAddToFavouritesButtonWasTapped(sender: UIButton) {
        delegate?.postAddToFavouritesButtonWasTapped(sender: sender)
    }
}

private extension ProfilePostTableViewCell {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupContent() {
        backgroundColor = .SocialNetworkColor.mainBackground
    }
    
    func setupLayout() {
        contentView.add(subviews: [postUserInfoView,
                                   postTitleLabel,
                                   postDescriptionLabel,
                                   postPhoto,
                                   postQuickActionsPanelView])
        
        postTitleLabel.snp.contentHuggingVerticalPriority = 999
        
        postUserInfoView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        postTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(postUserInfoView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        postDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(postTitleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        postPhoto.snp.makeConstraints { make in
            make.height.equalTo(125)
            make.top.equalTo(postDescriptionLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        postQuickActionsPanelView.snp.makeConstraints { make in
            make.top.equalTo(postPhoto.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}
