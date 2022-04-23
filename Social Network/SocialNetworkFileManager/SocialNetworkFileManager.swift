//
//  SocialNetworkFileManager.swift
//  Social_Network
//
//  Created by Arthur Raff on 23.04.2022.
//

import Foundation

class SocialNetworkFileManager {
    private let manager = FileManager.default
    
    func getDefault(directory: FileManager.SearchPathDirectory,
                    domain: FileManager.SearchPathDomainMask ) -> URL? {
        return try? manager.url(for: directory,
                                in: domain,
                                appropriateFor: nil,
                                create: false)
    }
    
    func getFileAttributesAt(path: String) -> [FileAttributeKey: Any]? {
        return try? manager.attributesOfItem(atPath: path)
    }
    
    func createDirectoryAt(path: String) {
        do {
            try manager.createDirectory(atPath: path,
                                        withIntermediateDirectories: true)
        } catch {
            print(error)
        }
    }
    
    func create(file: Data, path: String) {
        manager.createFile(atPath: path,
                           contents: file)
    }
    
    func removeFileOrDirectoryAt(path: String) {
        do {
            try manager.removeItem(atPath: path)
        } catch (let error) {
            print(error)
        }
    }
}
