//
//  UIImageViewDownloader.swift
//  Social_Network
//
//  Created by Arthur Raff on 23.02.2021.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async() { [weak self] in
                guard let self = self else { return }
                
                self.image = image
            }
        }
        
        task.resume()
    }
    
    func downloaded(from link: String) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url)
    }
}
