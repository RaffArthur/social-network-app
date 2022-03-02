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
    var appCoordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        FirebaseApp.configure()
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
    
        window = UIWindow(windowScene: windowScene)

        let navigationController: UINavigationController = .init()
        
        appCoordinator = AppCoordinator(navigationController)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        
        Auth.auth().addStateDidChangeListener { authResult, user in
            if user == nil {
                self.appCoordinator?.showLoginFlow()
            } else {
                self.appCoordinator?.showAppFlow()
            }
        }
    }
}
