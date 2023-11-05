//
//  PostCommentsTableViewCell.swift
//  Social_Network
//
//  Created by Arthur Raff on 04.11.2023.
//

import Foundation
import UIKit

final class PostCommentsTableViewCell: UITableViewCell {
    private lazy var userPhotoImage: UIImageView = {
        var iv = UIImageView()
        iv.isUserInteractionEnabled = true
        iv.image = UIImage(systemName: "photo.circle")
        iv.backgroundColor = .systemGray3
        iv.tintColor = .systemGray6
        iv.layer.masksToBounds = true
        
        return iv
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .SocialNetworkFont.subhead
        label.textAlignment = .left
        label.text = "Name Surname"
        label.textColor = .SocialNetworkColor.primaryText
        
        return label
    }()
    
    private lazy var userCommentText: UITextView = {
        let tv = UITextView()
        tv.isUserInteractionEnabled = false
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.font = .SocialNetworkFont.text
        tv.textColor = .SocialNetworkColor.primaryText
        tv.textAlignment = .left
        tv.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tv.textContainer.lineFragmentPadding = 0
        tv.backgroundColor = .clear
        
        return tv
    }()
    
    private lazy var commentDate: UILabel = {
        let label = UILabel()
        label.font = .SocialNetworkFont.caption2
        label.textAlignment = .left
        label.textColor = .SocialNetworkColor.secondaryText
        label.text = .localized(key: .statusPlaceholder)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var replyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ответить", for: .normal)
        button.setTitleColor(.SocialNetworkColor.tintIcon, for: .normal)
        button.titleLabel?.font = .SocialNetworkFont.caption2
        button.titleLabel?.textAlignment = .left
        button.contentHorizontalAlignment = .left
        
        return button
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.tintColor = .SocialNetworkColor.tintIcon
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.sizeToFit()
        
        return button
    }()
    
    private lazy var likesCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .SocialNetworkColor.tintIcon
        label.font = .SocialNetworkFont.caption2
        label.textAlignment = .right
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var likeContainer: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .equalSpacing
        sv.alignment = .fill
        sv.spacing = 4
        
        return sv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        userPhotoImage.layer.cornerRadius = userPhotoImage.frame.height / 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

private extension PostCommentsTableViewCell {
    func setupCell() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        add(subviews: [userPhotoImage,
                       userNameLabel,
                       userCommentText,
                       commentDate,
                       replyButton,
                       likeContainer])
        
        likeContainer.add(arrangedSubviews: [likeButton,
                                             likesCountLabel])
        
        userPhotoImage.snp.makeConstraints { make in
            make.size.equalTo(32)
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(userPhotoImage.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-16)
        }
                
        userCommentText.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(4)
            make.leading.equalTo(userPhotoImage.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        userCommentText.snp.contentHuggingVerticalPriority = 999
                
        commentDate.snp.makeConstraints { make in
            make.top.equalTo(userCommentText.snp.bottom).offset(4)
            make.leading.equalTo(userPhotoImage.snp.trailing).offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        replyButton.snp.makeConstraints { make in
            make.leading.equalTo(commentDate.snp.trailing).offset(8)
            make.centerY.equalTo(commentDate)
        }
        
        likeButton.snp.makeConstraints { make in
            make.size.equalTo(16)
        }
        
        likeContainer.snp.makeConstraints { make in
            make.centerY.equalTo(commentDate)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    func setupContent() {
        userPhotoImage.layer.cornerRadius = userPhotoImage.frame.height / 2

        backgroundColor = .SocialNetworkColor.mainBackground
    }
}

extension PostCommentsTableViewCell {
    func configure(comment: Comment) {
        userCommentText.text = comment.text
        userNameLabel.text = comment.userFullname
        commentDate.text = comment.date
        
        if comment.likes != nil {
            likesCountLabel.text = String(describing: comment.likes!)
        } else {
            likesCountLabel.isHidden = true
        }
    }
}
