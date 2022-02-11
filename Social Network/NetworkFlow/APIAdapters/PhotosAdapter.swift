//
//  PhotosAdapter.swift
//  Social_Network
//
//  Created by Arthur Raff on 17.08.2021.
//

import UIKit

class PhotosAdapter {
    public var onDataReceive: (() -> Void)?
    public var photos: [Photo] = []
    private let url = "https://jsonplaceholder.typicode.com/photos"
    private let networkManager = NetworkManager()
    
    func getPhotos(url: String) {
        guard let url = URL(string: url) else { return }
                
        networkManager.runDataTask(url: url) { [weak self] data in
            if let result = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    self.photos = try! decoder.decode([Photo].self, from: result)

                    self.onDataReceive?()
                }
            }
        }
    }
    
    func setupData() {
        if photos.isEmpty {
            getPhotos(url: url)
        } else {
            return
        }
    }
}
