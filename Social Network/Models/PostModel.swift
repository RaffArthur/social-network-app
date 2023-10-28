//
//  PostModel.swift
//  Social_Network
//
//  Created by Arthur Raff on 15.08.2021.
//

struct UserPost: Codable {
    let title: String?
    let body: String?
    let images: [String]?
    let likeCount: Int?
    let commentCount: Int?
}
