//
//  AppDelegate.swift
//  Navigation
//
//

import UIKit

@available(iOS 13.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print("Приложение было запущено")
        
        return true
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        print("Приложение будет запущено")

        return true  
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("Приложение стало активным")
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        print("Активность приложения будет присотановлена")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        /// Время работы в бэкграунд режиме от 29.5 до 29.8 сек.
        print("Приложение вошло в фоновый режим")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("Приложение будет выведено из фонового режима")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("Активность приложения будет прекращена")
        UIColor.SocialNetworkColor.mainBackground
    }
}
