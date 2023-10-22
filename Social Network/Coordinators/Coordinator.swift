//
//  Coordinator.swift
//  Social_Network
//
//  Created by Arthur Raff on 08.10.2021.
//

import UIKit

protocol Coordinator: AnyObject {
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    var type: CoordinatorType { get }
    
    init(_ navigationController: UINavigationController)

    func start()
    func finish()
}

extension Coordinator {
    func finish() {
        childCoordinators.removeAll()
        
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}

enum CoordinatorType {
    case app
    case login
    case tab
    case profile
    case favourite
    case photos
    case post
    case registration
    case mainProfileInfo
    case profileMenu
    case profileDetailedInfo
}
