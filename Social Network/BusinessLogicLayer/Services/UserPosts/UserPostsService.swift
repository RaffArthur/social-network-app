//
//  UserPostsService.swift
//  Social_Network
//
//  Created by Arthur Raff on 28.10.2023.
//

import Foundation

typealias UserPostFailureBlock = (FirebaseDatabaseError) -> Void

typealias PostCommentsSuccessBlock = ([Comment]) -> Void
typealias CommentSuccessBlock = (Any) -> Void

typealias PostLikesSuccessBlock = ([Like]) -> Void
typealias LikeSuccessBlock = (Any) -> Void

typealias UserPostsSuccessBlock = ([UserPost]) -> Void
typealias PostSuccessBlock = (Any) -> Void

protocol UserPostsService: AnyObject {
    // MARK: - UserPost
    func saveUserPost(userPost: UserPost,
                      failure: @escaping UserPostFailureBlock,
                      success: @escaping PostSuccessBlock)
    
    func getUserPosts(failure: @escaping UserPostFailureBlock,
                      success: @escaping UserPostsSuccessBlock)

    // MARK: - Favourite
    func saveToFavourite(userID: String,
                         postID: String,
                         isAddedToFavourite: Bool,
                         failure: @escaping UserPostFailureBlock,
                         success: @escaping PostSuccessBlock)
    
    func getFavouritePosts(failure: @escaping UserPostFailureBlock,
                           success: @escaping UserPostsSuccessBlock)
    
    func removeFromFavourite(userID: String,
                             postID: String,
                             favouriteID: String,
                             failure: @escaping UserPostFailureBlock,
                             success: @escaping PostSuccessBlock)

    // MARK: - Likes
    func savePostLike(userID: String,
                      postID: String,
                      isLiked: Bool,
                      failure: @escaping UserPostFailureBlock,
                      success: @escaping LikeSuccessBlock)
    
    func getPostLikes(postID: String,
                      failure: @escaping UserPostFailureBlock,
                      success: @escaping PostLikesSuccessBlock)
    
    func removePostLike(userID: String,
                        postID: String,
                        likeID: String,
                        failure: @escaping UserPostFailureBlock,
                        success: @escaping LikeSuccessBlock)
    // MARK: - Comments
    func saveUserComment(comment: Comment,
                         userID: String,
                         postID: String,
                         failure: @escaping UserPostFailureBlock,
                         success: @escaping CommentSuccessBlock)
    
    func getPostComments(postID: String,
                         failure: @escaping UserPostFailureBlock,
                         success: @escaping PostCommentsSuccessBlock)
}
