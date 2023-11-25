//
//  UserPostsService.swift
//  Social_Network
//
//  Created by Arthur Raff on 28.10.2023.
//

import Foundation

typealias GetUserPostsResult = (Result<[UserPost], UserPostError>) -> Void
typealias SaveUserPostResult = (Result<Any, UserPostError>) -> Void

typealias GetPostCommentsResult = (Result<[Comment], UserPostError>) -> Void
typealias SaveUserCommentResult = (Result<Any, UserPostError>) -> Void

typealias GetPostLikesResult = (Result<[Like], UserPostError>) -> Void
typealias SavePostLikeResult = (Result<Any, UserPostError>) -> Void

protocol UserPostsService: AnyObject {
    func saveUserPost(userPost: UserPost,
                      completion: @escaping SaveUserPostResult)
    
    func getUserPosts(completion: @escaping GetUserPostsResult)

    func savePostLike(userID: String,
                      postID: String,
                      isLiked: Bool,
                      completion: @escaping SavePostLikeResult)
    
    func getPostLikes(postID: String,
                      completion: @escaping GetPostLikesResult)
    
    func removePostLike(userID: String,
                        postID: String,
                        likeID: String)
    
    func saveUserComment(comment: Comment,
                         userID: String,
                         postID: String,
                         completion: @escaping SaveUserPostResult)
    
    func getPostComments(postID: String,
                         completion: @escaping GetPostCommentsResult)
}
