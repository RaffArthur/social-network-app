//
//  PhotosModel.swift
//  Social_Network
//
//  Created by Arthur Raff on 13.08.2021.
//

struct Photo: Codable {
    let albumID, id: Int?
    let title: String?
    let url, thumbnailURL: String?

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}
