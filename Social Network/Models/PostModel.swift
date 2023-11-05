//
//  PostModel.swift
//  Social_Network
//
//  Created by Arthur Raff on 15.08.2021.
//

struct UserPosts: Codable {
    var post: [String: UserPost]?
}

struct UserPost: Codable {
    let body: String?
    let images: [String]?
    let postLikes: [String]?
    var postComments: [String: Comment]?
}

struct Comment: Codable {
    let userID: String?
    let userPhoto: String?
    let userFullname: String?
    let text: String?
    let date: String?
    let likes: Int?
    var subcomments: [String: Subcomment]?
}

struct Subcomment: Codable {
    let userID: String?
    let userPhoto: String?
    let userFullname: String?
    let text: String?
    let date: String?
    let likes: Int?
}
