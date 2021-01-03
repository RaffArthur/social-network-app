//
//  Storage.swift
//  Navigation
//
//  Created by Arthur Raff on 12.10.2020.
//

import UIKit

struct UserPost {
    let author: String
    let description: String
    let image: String
    let likes: Int
    let views: Int
}

struct UserPhoto {
    let photo: String
}

struct UsersPostsStorage {
    static let posts = [
        UserPost(author: "HADSON", description: "🤔 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", image: "post_one", likes: 40, views: 200),
        UserPost(author: "Miles", description: "NICEEEE!!! Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", image: "post_two", likes: 9, views: 19),
        UserPost(author: "CrockFA", description: "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", image: "post_three", likes: 132, views: 672),
        UserPost(author: "JoeJoe", description: "🔥🔥🔥", image: "post_four", likes: 12, views: 111)
    ]
}

struct UsersPhotosStorage {
    static let photos = [
        UserPhoto(photo: "photo_1"),
        UserPhoto(photo: "photo_2"),
        UserPhoto(photo: "photo_3"),
        UserPhoto(photo: "photo_4"),
        UserPhoto(photo: "photo_5"),
        UserPhoto(photo: "photo_6"),
        UserPhoto(photo: "photo_7"),
        UserPhoto(photo: "photo_8"),
        UserPhoto(photo: "photo_1"),
        UserPhoto(photo: "photo_9"),
        UserPhoto(photo: "photo_10"),
        UserPhoto(photo: "photo_11"),
        UserPhoto(photo: "photo_12"),
        UserPhoto(photo: "photo_13"),
        UserPhoto(photo: "photo_14"),
        UserPhoto(photo: "photo_15"),
        UserPhoto(photo: "photo_16"),
        UserPhoto(photo: "photo_17"),
        UserPhoto(photo: "photo_18"),
        UserPhoto(photo: "photo_19"),
        UserPhoto(photo: "photo_20"),
    ]
}

