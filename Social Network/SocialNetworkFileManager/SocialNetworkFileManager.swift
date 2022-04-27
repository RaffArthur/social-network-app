//
//  SocialNetworkFileManager.swift
//  Social_Network
//
//  Created by Arthur Raff on 23.04.2022.
//

import Foundation

typealias FullFilesData = ([(file: URL,
                            attributes: [FileAttributeKey: Any])]) -> Void

enum FileManagerDirectory {
    case documentDirectory
    case userDirectory
    
    var url: URL? {
        switch self {
        case .documentDirectory:
            return try? FileManager.default.url(for: .documentDirectory,
                                                in: .userDomainMask,
                                                appropriateFor: nil,
                                                create: false)
        case .userDirectory:
            return try? FileManager.default.url(for: .userDirectory,
                                                in: .userDomainMask,
                                                appropriateFor: nil,
                                                create: false)
        }
    }
}

final class SocialNetworkFileManager {
    func getFilesWithAttributes(directory: FileManagerDirectory,
                                completion: FullFilesData) {
        var convertedFullFilesData = [(file: URL,
                              attributes: [FileAttributeKey: Any])]()
        
        guard let directoryUrl = directory.url else { return }
        
        let files = try? FileManager.default.contentsOfDirectory(at: directoryUrl,
                                                                 includingPropertiesForKeys: nil,
                                                                 options: [.skipsHiddenFiles])
        
        files?.forEach {
            var attributes: [FileAttributeKey : Any] = [:]
            let fileUrl = directoryUrl.appendingPathComponent($0.lastPathComponent)
            let fileExist = FileManager.default.fileExists(atPath: fileUrl.path)
            
            if fileExist == true {
                guard let convertedAttributes = try? FileManager.default.attributesOfItem(atPath: fileUrl.path)
                else {
                    return
                }
                attributes = convertedAttributes
            }
            
            convertedFullFilesData.append((file: $0, attributes: attributes))
        }
        
        completion(convertedFullFilesData)
    }
    
    
    func getFilesFrom(directory: FileManagerDirectory,
                      completion: ([URL]?) -> Void) {
        guard let directoryUrl = directory.url else { return }
        
        let files = try? FileManager.default.contentsOfDirectory(at: directoryUrl,
                                                                 includingPropertiesForKeys: nil,
                                                                 options: [.skipsHiddenFiles])
        
        completion(files)
    }
    
    func getFileAttributesFrom(directory: FileManagerDirectory,
                               atName name: String,
                               completion: ([FileAttributeKey: Any]?) -> Void ) {
        guard let directoryUrl = directory.url else { return }
        
        let fileUrl = directoryUrl.appendingPathComponent(name)
        let fileExist = FileManager.default.fileExists(atPath: fileUrl.path)
        
        if fileExist == true {
            let attributes = try? FileManager.default.attributesOfItem(atPath: fileUrl.path)
            
            completion(attributes)
        }
    }
    
    func create(file: Data,
                withName name: String,
                atDirectory directory: FileManagerDirectory) {
        guard let directoryUrl = directory.url else { return }
        
        let fileUrl = directoryUrl.appendingPathComponent(name)

        FileManager.default.createFile(atPath: fileUrl.path,
                                       contents: file)        
    }
    
    func removeFileAt(directory: FileManagerDirectory,
                      withName name: String) {
        guard let directoryUrl = directory.url else { return }
        
        let fileUrl = directoryUrl.appendingPathComponent(name)
        
        try? FileManager.default.removeItem(atPath: fileUrl.path)
    }
}
