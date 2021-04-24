//
//  SceneDelegate.swift
//  Social_Network
//
//  Created by Arthur Raff on 09.01.2021.
//

import UIKit
import SwiftyJSON

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: AppCoordinator?
    
    private let urlsList = [AppConfiguration.URLOne("https://swapi.dev/api/films/12"),
                    AppConfiguration.URLTwo("https://swapi.dev/api/people/2"),
                    AppConfiguration.URLTwo("http://swapi.dev/api/species/7")]
    
    private func getURLFromAppConfiguration(appConfig: AppConfiguration?) -> String? {
        if case .URLOne(let value) = appConfig {
            return value
        }

        if case .URLTwo(let value) = appConfig {
            return value
        }

        if case .URLThree(let value) = appConfig {
            return value
        }

        return ""
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // MARK: - Start URLSesion data tsk
        let randomURL = getURLFromAppConfiguration(appConfig: urlsList.randomElement())
        
        guard let serverURL = randomURL else { return}
        
        let endURL = URL(string: serverURL)
        
        guard let url = endURL else { return }

        NetworkManager.runDataTask(url: url) { string in
            guard let string = string else {
                return
            }
            
            print("Получены данные с сервера: \(string)")
        }
       
        // MARK: - Creation of WindowScene and coordinators.
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
