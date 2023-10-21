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
    private lazy var backgroundContext = persistentContainer.newBackgroundContext()
    
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
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension CoreDataManager {
    func saveToFavourite(post: Post) {
        backgroundContext.perform { [weak self] in
            guard let isPostAddedToFavourite = post.isPostAddedToFavourite,
                  let isPostLiked = post.isPostLiked
            else {
                return
            }
            
            let favouritePost = FavouritePost(context: self?.backgroundContext ?? NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType))
            favouritePost.title = post.title
            favouritePost.body = post.body
            favouritePost.likes = post.likes
            favouritePost.comments = post.comments
            favouritePost.isPostAddedToFavurite = isPostAddedToFavourite
            favouritePost.isPostLiked = isPostLiked
            
            self?.save()
        }
    }
    
    func fetchFavouritePosts(completion: @escaping ([FavouritePost]) -> Void) {
        backgroundContext.perform { [weak self] in
            let request = FavouritePost.fetchRequest()
            
            request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
            
            guard let favouritePosts = try? self?.backgroundContext.fetch(request) else { return }
            
            completion(favouritePosts)
        }
    }
    
    func removePostFrom(favouritePosts: FavouritePost) {
        backgroundContext.perform { [weak self] in
            self?.backgroundContext.delete(favouritePosts)
            
            self?.save()
        }
    }
    
    func deletAll() {
        backgroundContext.perform { [weak self] in
            self?.fetchFavouritePosts { [weak self] in
                $0.forEach { self?.backgroundContext.delete($0) }
            }
            
            self?.save()
        }
    }
}
