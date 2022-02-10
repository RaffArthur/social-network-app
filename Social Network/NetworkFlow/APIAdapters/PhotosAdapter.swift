//
//  PhotosAdapter.swift
//  Social_Network
//
//  Created by Arthur Raff on 17.08.2021.
//

import UIKit

class PhotosAdapter: APIAdapter {
    public var onDataReceive: (() -> Void)?
    public var dataSource = PhotoStorage.photos
    private let url = URLDomains.photosURL
    private let networkManager = NetworkManager()

    func receiveData(from url: URL?) {
        if let url = url {
            networkManager.runDataTask(url: url) { [weak self] data in
                if let result = data {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        
                        self.dataSource = try! decoder.decode([Photo].self, from: result)

                        self.onDataReceive?()
                    }
                }
            }
        }
    }
    
    func setupData() {
        if dataSource.isEmpty {
            receiveData(from: url)
        } else {
            return
        }
    }
}
