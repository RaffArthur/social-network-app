//
//  AppCoordinator.swift
//  Social_Network
//
//  Created by Arthur Raff on 11.10.2021.
//

import UIKit

final class AppCoordinator: Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate? = nil
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var type: CoordinatorType { .app }
    
    private var realmDataProvider: RealmUserCredentialsDataProvider?
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }
    
    func start() {
        realmDataProvider = RealmUserCredentialsDataProviderImpl()
        
        let userCredentials = realmDataProvider?.getUserCredentials()
        
        if userCredentials == nil || userCredentials?.loggedIn == false {
            showAuthentificationFlow()
        } else {
            showAppFlow()
        }
    }
}

private extension AppCoordinator {
    func showAuthentificationFlow() {
        let coordinator = LoginCoordinator(navigationController)
        coordinator.finishDelegate = self
        coordinator.start()
        
        childCoordinators.append(coordinator)
    }
    
    func showAppFlow() {
        let coordinator = TabCoordinator(navigationController)
        coordinator.finishDelegate = self
        coordinator.start()
        
        childCoordinators.append(coordinator)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0.type != childCoordinator.type }
        
        switch childCoordinator.type {
        case .tab:
            navigationController.viewControllers.removeAll()
            
            showAuthentificationFlow()
        case .login:
            navigationController.viewControllers.removeAll()
            
            showAppFlow()
        default:
            break
        }
    }
}
