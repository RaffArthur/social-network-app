//
//  SceneDelegate.swift
//  Social_Network
//
//  Created by Arthur Raff on 09.01.2021.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
    
        window = UIWindow(windowScene: windowScene)

        let navigationController: UINavigationController = .init()
        
        window?.backgroundColor = .SocialNetworkColor.mainBackground
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont.SocialNetworkFont.t2]
        
        appCoordinator = AppCoordinator(navigationController)
        appCoordinator?.start()
    }
}
