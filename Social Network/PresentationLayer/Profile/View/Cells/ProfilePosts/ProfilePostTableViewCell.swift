//
//  ProfilePostTableViewCell.swift
//  Navigation
//
//  Created by Arthur Raff on 12.10.2020.
//

import Foundation
import UIKit

final class ProfilePostTableViewCell: UITableViewCell {
    private lazy var postTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .SocialNetworkColor.mainText.set()
        label.numberOfLines = 2
        label.lineBreakMode = .byClipping
        
        return label
    }()
    
    private lazy var postDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .SocialNetworkColor.mainText.set()
        label.numberOfLines = 0
        
        return label
    }()

    private lazy var postPhoto: UIImageView = {
        let iv = UIImageView()
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 18
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "photo.fill")
        iv.backgroundColor = .SocialNetworkColor.accent.set()
        iv.tintColor = .white
        
        return iv
    }()
    
    private lazy var postLikesButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .SocialNetworkColor.mainText.set()
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        return button
    }()
    
    private lazy var postCommentsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "message"), for: .normal)
        button.tintColor = .SocialNetworkColor.mainText.set()
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        return button
    }()
    
    private lazy var postAddToFavouritesButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = .SocialNetworkColor.mainText.set()
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        return button
    }()
    
    private lazy var postLikesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .SocialNetworkColor.mainText.set()
        
        return label
    }()
    
    private lazy var postCommentsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .SocialNetworkColor.mainText.set()
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfilePostTableViewCell {
    func configure(post: Post) {
        guard let postTitle = post.title,
              let postDescription = post.body
        else {
            return
        }

        self.postTitleLabel.text = postTitle.firstUppercased
        self.postDescriptionLabel.text = postDescription.firstUppercased
        self.postLikesLabel.text = String(describing: Int.random(in: 100...500))
        self.postCommentsLabel.text = String(describing: Int.random(in: 200...1000))
    }
    
    func configure(post: FavouritePost) {
        guard let postTitle = post.title,
              let postDescription = post.body
        else {
            return
        }

        self.postTitleLabel.text = postTitle.firstUppercased
        self.postDescriptionLabel.text = postDescription.firstUppercased
        self.postLikesLabel.text = String(describing: Int.random(in: 100...500))
        self.postCommentsLabel.text = String(describing: Int.random(in: 200...1000))
    }
}

private extension ProfilePostTableViewCell {
    func setupLayout() {
        contentView.add(subviews: [postTitleLabel,
                                   postDescriptionLabel,
                                   postPhoto,
                                   postLikesButton,
                                   postCommentsButton,
                                   postAddToFavouritesButton,
                                   postLikesLabel,
                                   postCommentsLabel])
        
        postTitleLabel.snp.contentHuggingVerticalPriority = 999

        postTitleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
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
        
        postLikesButton.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.top.equalTo(postPhoto.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
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
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(postLikesButton)
        }
    }
}
