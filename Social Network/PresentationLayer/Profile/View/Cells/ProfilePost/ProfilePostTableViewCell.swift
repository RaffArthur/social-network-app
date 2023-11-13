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
        
        delegate = .none
        postQuickActionsPanelView.prepareForReuse()
    }
}

extension ProfilePostTableViewCell {
    func configureWith(indexPath: IndexPath,
                       userPost: UserPost,
                       userName: String,
                       userRegalia: String,
                       isPostLiked: Bool,
                       isPostAddedToFavourite: Bool) {
        guard let postbody = userPost.body,
              let postImage = userPost.image,
              let postLikeCount = userPost.postLikes?.count,
              let postCommentCount = userPost.postComments?.count
        else {
            return
        }
        
        postMainInfoView.configurePostMainInfo(body: postbody.firstUppercased,
                                               image: nil)
        
        postQuickActionsPanelView.configurePostQuickActionsPanelWith(indexPath: indexPath,
                                                                     postLikes: String(describing: postLikeCount),
                                                                     postComments: String(describing: postCommentCount),
                                                                     isPostLiked: isPostLiked,
                                                                     isPostAddedToFavourite: isPostAddedToFavourite)
        
        postUserInfoView.configurePostUserInfo(name: userName,
                                               regalia: userRegalia)
    }
}

extension ProfilePostTableViewCell: ProfilePostQuickActionsPanelViewDelegate {
    func postLikesButtonWasTappedAt(indexPath: IndexPath) {
        delegate?.postLikesButtonWasTappedAt(indexPath: indexPath)
    }
    
    func postCommentsButtonWasTappedAt(indexPath: IndexPath) {
        delegate?.postCommentsButtonWasTappedAt(indexPath: indexPath)
    }
    
    func postAddToFavouritesButtonWasTappedAt(indexPath: IndexPath) {
        delegate?.postAddToFavouritesButtonWasTappedAt(indexPath: indexPath)
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
