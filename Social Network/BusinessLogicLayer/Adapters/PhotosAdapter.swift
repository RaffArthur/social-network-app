//
//  PhotosAdapter.swift
//  Social_Network
//
//  Created by Arthur Raff on 17.08.2021.
//

import UIKit

struct UserPhotosSuccessAdapterResult {
    let photos: [Photo]
}

typealias UserPhotosSuccessAdapterBlock = (_ result: UserPhotosSuccessAdapterResult) -> Void

class PhotosAdapter {
    func getPhotos(success: @escaping UserPhotosSuccessAdapterBlock) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
        else {
            return
        }

        NetworkManager().runDataTask(url: url) { data in
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            if let photos = try? decoder.decode([Photo].self, from: data) {
                let result = UserPhotosSuccessAdapterResult(photos: photos)
                
                DispatchQueue.main.async {
                    success(result)
                }
            }
        }
    }
}
