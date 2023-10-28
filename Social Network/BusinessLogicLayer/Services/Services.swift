//
//  Services.swift
//  Social_Network
//
//  Created by Arthur Raff on 17.10.2023.
//

import Foundation

struct Services {
    static func userDataService() -> UserDataService{
        return UserDataServiceImpl()
    }
    
    static func userPostsService() -> UserPostsService{
        return UserPostsServiceImpl()
    }
}
