//
//  UserFavouritePostsService.swift
//  Social_Network
//
//  Created by Arthur Raff on 29.10.2023.
//

import Foundation

typealias GetUserFavouritePostsResult = (Result<[UserPost], UserPostError>) -> Void
typealias SaveToFavouriteUserPostResult = (Result<Any, UserPostError>) -> Void

protocol UserFavouritePostsService: AnyObject {
    func addUserPostToFavourite(userPost: UserPost, completion: @escaping SaveToFavouriteUserPostResult)
    func getUserFavouritePosts(completion: @escaping GetUserFavouritePostsResult)
    func removeUserPostFromFavourite(favouritePostID: String)
    func removeAllUserPostFromFavourite()
}
