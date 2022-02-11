//
//  NetworkManager.swift
//  Social_Network
//
//  Created by Arthur Raff on 13.04.2021.
//
import UIKit

class NetworkManager {
    private var session = URLSession.shared
    
    public func runDataTask(url: URL, completion: @escaping (Data?) -> Void) {
        let dataTask = session.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else { return }
            guard error == nil else { return }
            guard data == data else { return }
            
            print(httpResponse.statusCode)
            
            completion(data)
        }
        
        dataTask.resume()
    }
    
    public func returnObject(from json: Data) throws -> [String: Any]? {
        let jsonObject = try? JSONSerialization.jsonObject(with: json, options: .mutableContainers) as? [String: Any]
        
        return jsonObject
    }
}
