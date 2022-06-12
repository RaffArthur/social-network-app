//
//  PhotosModel.swift
//  Social_Network
//
//  Created by Arthur Raff on 13.08.2021.
//

struct Photo: Codable {
    let url: String?
    let thumbnailURL: String?

    enum CodingKeys: String, CodingKey {
        case url
        case thumbnailURL = "thumbnailUrl"
    }
}
