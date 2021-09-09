//
//  SceneDelegate.swift
//  Social_Network
//
//  Created by Arthur Raff on 09.01.2021.
//

import UIKit
import Firebase

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: AppCoordinator?
        
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        FirebaseApp.configure()

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let rootViewController = TabBarViewController()

        coordinator = AppCoordinator(tabBarController: rootViewController)
        rootViewController.coordinator = coordinator
        rootViewController.tabBarController?.tabBar.isHidden = true
        coordinator?.start()
                                
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
}
