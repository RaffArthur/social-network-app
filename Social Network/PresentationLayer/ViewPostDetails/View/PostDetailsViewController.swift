//
//  PostDetailsViewController.swift
//  Social_Network
//
//  Created by Arthur Raff on 04.11.2023.
//

import Foundation
import UIKit

final class PostDetailsViewController: UIViewController {
    private lazy var userPostService = Services.userPostsService()
    
    private lazy var postDetailesView = PostDetailsView()
    private lazy var commentsHeaderView = PostCommentsHeaderView()
    
    private lazy var userID = String()
    private lazy var postID = String()
    
    private lazy var postComments = [Comment]()
    
    private var userPost = UserPost(id: nil,
                                    body: nil,
                                    image: nil,
                                    postLikes: nil,
                                    postComments: nil,
                                    postFavourites: nil)
    private var userName = String()
    private var userRegalia = String()
    private var indexPath = IndexPath()
    private var isPostLiked = Bool()
    private var isPostAddedToFavourite = Bool()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadPostComments()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postDetailesView.tableView(delegate: self, dataSource: self)
        postDetailesView.delegate = self
        
        setupContent()
        
        postDetailesView.tableViewReloadData()
    }
    
    override func loadView() {
        view = postDetailesView
    }
}

extension PostDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension PostDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        if section == 1 {
            return postComments.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let identifier = String(describing: ProfilePostTableViewCell.self)
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier ,
                                                     for: indexPath) as? ProfilePostTableViewCell
            
            cell?.selectionStyle = .none
            
            cell?.configureWith(indexPath: indexPath,
                                userPost: userPost,
                                userName: userName,
                                userRegalia: userRegalia,
                                isPostLiked: isPostLiked,
                                isPostAddedToFavourite: isPostAddedToFavourite)
            
            return cell ?? UITableViewCell()
        } 
        
        if indexPath.section == 1 {
            let identifier = String(describing: PostCommentsTableViewCell.self)
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                     for: indexPath) as? PostCommentsTableViewCell
            
            cell?.selectionStyle = .default
            
            let comment = postComments[indexPath.row]
            
            cell?.configure(comment: comment)
            
            return cell ?? UITableViewCell()
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            commentsHeaderView.configure(commentsCount: "\(postComments.count) КОММЕНТАРИЕВ".uppercased())
            
            return commentsHeaderView
        }
        
        return UIView()
    }
}

private extension PostDetailsViewController {
    func setupContent() {
        title = "Запись"
        
        view.backgroundColor = .SocialNetworkColor.mainBackground
    }
}

private extension PostDetailsViewController {
    func loadPostComments() {
        userPostService.getPostComments(postID: postID) { [weak self] error in
            print(error)
        } success: { [weak self] comments in
            self?.postComments = comments
            
            self?.postDetailesView.tableViewReloadData()
        }
    }
}

extension PostDetailsViewController: PostDetailsViewDelegate {
    func sendCommentButtonWasTapped(withText: String) {
        let comment = Comment(id: nil,
                              userCommentedID: nil,
                              userPhoto: "",
                              userFullname: userName,
                              text: withText,
                              date: "10.10.110",
                              likes: 0)
        
        userPostService.saveUserComment(comment: comment,
                                        userID: userID,
                                        postID: postID) { [weak self] error in
            print(error)
        } success: { [weak self] commentID in
            self?.postDetailesView.tableViewReloadData()

            print(commentID)
        }
        
        loadPostComments()
        
        postDetailesView.tableViewReloadData()
    }
}

extension PostDetailsViewController {
    func configureView(userID: String,
                       postID: String,
                       post: UserPost,
                       userName: String,
                       userRegalia: String,
                       indexPath: IndexPath,
                       isPostLiked: Bool,
                       isPostAddedToFavourite: Bool) {
        self.userID = userID
        self.postID = postID
        self.userPost = post
        self.userName = userName
        self.userRegalia = userRegalia
        self.indexPath = indexPath
        self.isPostLiked = isPostLiked
        self.isPostAddedToFavourite = isPostAddedToFavourite
    }
}
