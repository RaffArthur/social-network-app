//
//  UserPostsService.swift
//  Social_Network
//
//  Created by Arthur Raff on 28.10.2023.
//

import Foundation

typealias GetUserPostsResult = (Result<[UserPost], UserPostError>) -> Void
typealias SaveUserPostResult = (Result<Any, UserPostError>) -> Void

protocol UserPostsService: AnyObject {
    func saveUserPost(userPost: UserPost, completion: @escaping SaveUserPostResult)
    func getUserPosts(completion: @escaping GetUserPostsResult)
}
