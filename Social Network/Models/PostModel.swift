//
//  PostModel.swift
//  Social_Network
//
//  Created by Arthur Raff on 15.08.2021.
//

struct UserPosts: Codable {
    var posts: [String: UserPost]?
}
struct UserPost: Codable {
    let body: String?
    let images: [String]?
    let likeCount: Int?
    let commentCount: Int?
}
