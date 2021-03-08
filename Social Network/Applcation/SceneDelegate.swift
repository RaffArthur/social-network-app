//
//  SceneDelegate.swift
//  Social_Network
//
//  Created by Arthur Raff on 09.01.2021.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

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

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }
}
