//
//  NetworkManager.swift
//  Social_Network
//
//  Created by Arthur Raff on 13.04.2021.
//

import UIKit
typealias DataCallback = (String?) -> Void

struct NetworkManager {
    static var session = URLSession.shared
    
    static func runDataTask(url: URL, completion: @escaping DataCallback) {
        
        let dataTask = session.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            print("Код статуса: \(httpResponse.statusCode)")
            print("Данные заголовка HTTP:\(httpResponse.allHeaderFields)")
            
            guard error == nil else {
                print("Ошибка: \(String(describing: error))")
                print("Ошибка (отключенный wi-fi): \(String(describing: error?.localizedDescription))")
                return
            }
            print("Ошибка: \(String(describing: error))")
            print("Ошибка (отключенный wi-fi): \(String(describing: error?.localizedDescription))")
            
            if let data = data {
                completion(String(data: data, encoding: .utf8))
                print(String(describing: data))
            }
        }
        
        dataTask.resume()
    }
}
