//
//  SceneDelegate.swift
//  Social_Network
//
//  Created by Arthur Raff on 09.01.2021.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    var coreDataManager: CoreDataManager?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        
        coreDataManager = CoreDataManagerImpl(modelName: "FavouritePost")
        
        coreDataManager?.load {
            print("Successfull")
        }
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
    
        window = UIWindow(windowScene: windowScene)

        let navigationController: UINavigationController = .init()
        
        appCoordinator = AppCoordinator(navigationController)
        
        appCoordinator?.start()

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
