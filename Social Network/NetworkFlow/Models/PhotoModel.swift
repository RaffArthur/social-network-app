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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        albumID = try container.decode(Int.self, forKey: .albumID)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        url = try container.decode(String.self, forKey: .url)
        thumbnailURL = try container.decode(String.self, forKey: .thumbnailURL)
    }
}

struct PhotoStorage {
    public static var photos: [Photo] = []
}
