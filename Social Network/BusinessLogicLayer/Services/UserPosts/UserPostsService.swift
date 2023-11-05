//
//  UserPostsService.swift
//  Social_Network
//
//  Created by Arthur Raff on 28.10.2023.
//

import Foundation

typealias GetUserPostsResult = (Result<UserPosts, UserPostError>) -> Void
typealias SaveUserPostResult = (Result<Any, UserPostError>) -> Void

typealias GetPostCommentsResult = (Result<[Comment], UserPostError>) -> Void
typealias SaveUserCommentResult = (Result<Any, UserPostError>) -> Void

protocol UserPostsService: AnyObject {
    func saveUserPost(userPost: UserPost,
                      completion: @escaping SaveUserPostResult)
    
    func getUserPosts(completion: @escaping GetUserPostsResult)

    func likeAUsersPost(userID: String,
                        postID: String)
    
    func dislikeAUsersPost(userID: String,
                           postID: String)
    
    func saveUserComment(comment: Comment,
                         userID: String,
                         postID: String,
                         completion: @escaping SaveUserPostResult)
    
    func getPostComments(postID: String, completion: @escaping GetPostCommentsResult)
}
