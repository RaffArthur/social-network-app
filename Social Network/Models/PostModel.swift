//
//  PostModel.swift
//  Social_Network
//
//  Created by Arthur Raff on 15.08.2021.
//

struct UserPost: Codable {
    let id: String?
    let body: String?
    let image: String?
    let postLikes: [Like]?
    let postComments: [Comment]?
}

struct Like: Codable {
    let id: String
    let likedUserID: String?
}

struct Comment: Codable {
    let id: String?
    let userCommentedID: String?
    let userPhoto: String?
    let userFullname: String?
    let text: String?
    let date: String?
    let likes: Int?
}
