//
//  PostModel.swift
//  Social_Network
//
//  Created by Arthur Raff on 15.08.2021.
//

struct Post: Codable {
    let userID, id: Int?
    let title, body: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
