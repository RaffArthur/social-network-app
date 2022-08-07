//
//  ProfilePostTableViewCell.swift
//  Navigation
//
//  Created by Arthur Raff on 12.10.2020.
//

import UIKit

class ProfilePostTableViewCell: UITableViewCell {
    private lazy var postTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .SocialNetworkColor.mainText.set()
        label.numberOfLines = 2
        
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
    
    private lazy var postDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .SocialNetworkColor.mainText.set()
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var postLikes: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .SocialNetworkColor.accent.set()
        
        return label
    }()
    
    private lazy var postViews: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .SocialNetworkColor.accent.set()
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(post: Post) {
        guard let postTitle = post.title,
              let postDescription = post.body
        else {
            return
        }

        self.postTitle.text = postTitle.firstUppercased
        self.postDescription.text = postDescription.firstUppercased
        self.postLikes.text = .setLocalizedPluralStringWith(key: .postLikes,
                                                            argument: Int.random(in: 100...500))
        self.postViews.text = .setLocalizedPluralStringWith(key: .postViews,
                                                            argument: Int.random(in: 200...1000))
    }
    
    func configure(post: FavouritePost) {
        guard let postTitle = post.title,
              let postDescription = post.body
        else {
            return
        }

        self.postTitle.text = postTitle.firstUppercased
        self.postDescription.text = postDescription.firstUppercased
        self.postLikes.text = .setLocalizedPluralStringWith(key: .postLikes,
                                                            argument: Int.random(in: 100...500))
        self.postViews.text = .setLocalizedPluralStringWith(key: .postViews,
                                                            argument: Int.random(in: 200...1000))
    }
}

private extension ProfilePostTableViewCell {
    func setupLayout() {
        contentView.add(subviews: [postTitle,
                                   postPhoto,
                                   postDescription,
                                   postLikes,
                                   postViews])
        
        postTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        postPhoto.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.top.equalTo(postTitle.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        postDescription.snp.makeConstraints { make in
            make.top.equalTo(postPhoto.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        postLikes.snp.makeConstraints { make in
            make.top.equalTo(postDescription.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        postViews.snp.makeConstraints { make in
            make.centerY.equalTo(postLikes)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}
