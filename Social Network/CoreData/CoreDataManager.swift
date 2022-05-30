//
//  CoreDataManager.swift
//  Social_Network
//
//  Created by Arthur Raff on 28.05.2022.
//

import Foundation
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager(modelName: "SocialNetworkCoreData")
    
    private let persistentContainer: NSPersistentContainer
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (() -> Void)?) {
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else { return }
            
            completion?()
        }
    }
    
    private func save() {
        if persistentContainer.viewContext.hasChanges {
            do {
                try persistentContainer.viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension CoreDataManager {
    func saveToFavourite(post: Post) {
        let favouritePost = FavouritePost(context: persistentContainer.viewContext)
        favouritePost.title = post.title
        favouritePost.body = post.body
        
        save()        
    }
    
    func fetchFavouritePosts() -> [FavouritePost] {
        let request = FavouritePost.fetchRequest()
        
        let favouritePosts = try? persistentContainer.viewContext.fetch(request)
        
        return favouritePosts ?? []
    }
    
    func removePostFrom(favouritePosts: FavouritePost) {
        persistentContainer.viewContext.delete(favouritePosts)
        
        save()
    }
    
    func deletAll() {
        fetchFavouritePosts().forEach {
            persistentContainer.viewContext.delete($0)
        }
        
        save()
    }
}
