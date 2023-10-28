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
    private lazy var postMainInfoView = ProfilePostMainInfoView()
    private lazy var postQuickActionsPanelView = ProfilePostQuickActionsPanelView()
    
    private lazy var postContainer: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var postStackView: UIStackView = {
        let sv = UIStackView()
        sv.alignment = .fill
        sv.distribution = .equalSpacing
        sv.axis = .vertical
        sv.spacing = 16
        
        return sv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                        
        setupScreen()
        
        postQuickActionsPanelView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
}

extension ProfilePostTableViewCell {
    func configure(userPost: UserPost,
                   userName: String,
                   userRegalia: String,
                   indexPath: IndexPath,
                   isPostLiked: Bool,
                   isPostAddedToFavourite: Bool) {
        guard let postTitle = userPost.title,
              let postbody = userPost.body,
              let postLikeCount = userPost.likeCount,
              let postCommentCount = userPost.commentCount
        else {
            return
        }
        
        postMainInfoView.configurePostMainInfo(title: postTitle,
                                               description: postbody.firstUppercased,
                                               image: "photo.fill")
        
        postQuickActionsPanelView.configurePostQuickActionsPanel(postLikes: String(describing: postLikeCount),
                                                                 postComments: String(describing: postCommentCount),
                                                                 indexPath: indexPath,
                                                                 isPostLiked: isPostLiked,
                                                                 isPostAddedToFavourite: isPostAddedToFavourite)
        
        postUserInfoView.configurePostUserInfo(name: userName,
                                               regalia: userRegalia)
    }
    
//    func configure(post: FavouritePost,
//                   userName: String,
//                   userRegalia: String,
//                   indexPath: IndexPath,
//                   isPostLiked: Bool,
//                   isPostAddedToFavourite: Bool) {
//        guard let postTitle = post.title,
//              let postDescription = post.body,
//              let postLikes = post.likes,
//              let postComments = post.comments
//        else {
//            return
//        }
//        
//        postMainInfoView.configurePostMainInfo(title: postTitle,
//                                               description: postDescription.firstUppercased,
//                                               image: "photo.fill")
//        
//        postQuickActionsPanelView.configurePostQuickActionsPanel(postLikes: postLikes,
//                                                                 postComments: postComments, 
//                                                                 indexPath: indexPath,
//                                                                 isPostLiked: isPostLiked,
//                                                                 isPostAddedToFavourite: isPostAddedToFavourite)
//        
//        postUserInfoView.configurePostUserInfo(name: userName,
//                                               regalia: userRegalia)
//    }
}

extension ProfilePostTableViewCell: ProfilePostQuickActionsPanelViewDelegate {
    func postLikesButtonWasTapped(indexPath: IndexPath) {
        delegate?.postLikesButtonWasTapped(indexPath: indexPath)

    }
    
    func postCommentsButtonWasTapped(indexPath: IndexPath) {
        delegate?.postCommentsButtonWasTapped(indexPath: indexPath)
    }
    
    func postAddToFavouritesButtonWasTapped(indexPath: IndexPath) {
        delegate?.postAddToFavouritesButtonWasTapped(indexPath: indexPath)

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
        contentView.addSubview(postContainer)
        
        postContainer.addSubview(postStackView)
        
        postStackView.add(arrangedSubviews: [postUserInfoView,
                                             postMainInfoView,
                                             postQuickActionsPanelView])
                
        postContainer.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.bottom.trailing.equalToSuperview().offset(-16)
        }
        
        postStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
