//
//  Coordinators.swift
//  Social_Network
//
//  Created by Arthur Raff on 09.02.2021.
//

import UIKit

protocol TabBarCoordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var tabBarController: UITabBarController { get set }
        
    func start()
}

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    
    func start()
}

extension Coordinator {
    func push(vc: UIViewController, animated: Bool) {
        navigationController.pushViewController(vc, animated: animated)
    }
}
