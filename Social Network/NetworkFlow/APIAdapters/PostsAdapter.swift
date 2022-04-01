//
//  PostsAdapter.swift
//  Social_Network
//
//  Created by Arthur Raff on 17.08.2021.
//

import UIKit

struct UserPostsSuccessAdapterResult {
    let posts: [Post]
}

typealias UserPostSuccessAdapterBlock = (_ result: UserPostsSuccessAdapterResult) -> Void

class PostsAdapter {
    func getPosts(success: @escaping UserPostSuccessAdapterBlock) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        else {
            return
        }

        NetworkManager().runDataTask(url: url) { data in
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let posts = try! decoder.decode([Post].self, from: data)
            let result = UserPostsSuccessAdapterResult(posts: posts)
            
            DispatchQueue.main.sync {
                success(result)
            }
        }
    }
}
