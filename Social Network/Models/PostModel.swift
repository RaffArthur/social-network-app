//
//  PostModel.swift
//  Social_Network
//
//  Created by Arthur Raff on 15.08.2021.
//

struct Post: Codable {
    let title: String?
    let body: String?
    let isPostLiked: Bool?
    let isPostAddedToFavourite: Bool?
    let likes: String?
    let comments: String?
}
