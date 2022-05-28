//
//  CoreDataManagerImpl.swift
//  Social_Network
//
//  Created by Arthur Raff on 28.05.2022.
//

import Foundation
import CoreData

final class CoreDataManagerImpl: CoreDataManager {
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext { return persistentContainer.viewContext }
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (() -> Void)?) {
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else { return }
            
            completion?()
        }
    }
}
