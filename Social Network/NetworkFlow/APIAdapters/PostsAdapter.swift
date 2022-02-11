//
//  PostsAdapter.swift
//  Social_Network
//
//  Created by Arthur Raff on 17.08.2021.
//

import UIKit

class PostsAdapter {
    public var onDataReceive: (() -> Void)?
    public var posts: [Post] = []
    private let url = "https://jsonplaceholder.typicode.com/posts"
    private let networkManager = NetworkManager()
    
    func getPosts(url: String) {
        guard let url = URL(string: url) else { return }

        networkManager.runDataTask(url: url) { [weak self] data in
            if let result = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }

                    self.posts = try! decoder.decode([Post].self, from: result)

                    self.onDataReceive?()
                }
            }
        }
    }
    
    func setupData() {
        if posts.isEmpty {
            getPosts(url: url)
        } else {
            return
        }
    }
}
