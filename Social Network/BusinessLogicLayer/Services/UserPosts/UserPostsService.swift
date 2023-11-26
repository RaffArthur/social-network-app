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

typealias GetPostFavouritesResult = (Result<[UserPost], UserPostError>) -> Void
typealias SavePostFavouritesResult = (Result<Any, UserPostError>) -> Void


protocol UserPostsService: AnyObject {
    func saveUserPost(userPost: UserPost,
                      completion: @escaping SaveUserPostResult)
    
    func getUserPosts(completion: @escaping GetUserPostsResult)

    func savePostLike(userID: String,
                      postID: String,
                      isLiked: Bool,
                      completion: @escaping SavePostLikeResult)
    
    func saveToFavourite(userID: String,
                         postID: String,
                         isAddedToFavourite: Bool,
                         completion: @escaping SavePostFavouritesResult)
    
    func getFavouritePosts(completion: @escaping GetPostFavouritesResult)
    
    func removeFromFavourite(userID: String,
                             postID: String,
                             favouriteID: String)

    
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
