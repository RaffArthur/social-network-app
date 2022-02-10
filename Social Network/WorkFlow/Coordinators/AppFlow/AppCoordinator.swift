//
//  AppCoordinator.swift
//  Social_Network
//
//  Created by Arthur Raff on 11.10.2021.
//

import UIKit

// MARK: - AppCoordinatorProtocol
/// Главный координатор, как входная и отправная точка всего приложения
@available(iOS 13.0, *)
protocol AppCoordinatorProtocol: Coordinator {
    func showLoginFlow()
    func showAppFlow()
}

// MARK: - AppCoordinator
// Координатор приложения - единственный координатор, который будет существовать весь жизненный цикл приложения
@available(iOS 13.0, *)
class AppCoordinator: AppCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate? = nil
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var type: CoordinatorType { .app }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }
    
    func start() {
        showLoginFlow()
    }
    
    func showLoginFlow() {
        let loginCoordinator = LoginCoordinator(navigationController)
        loginCoordinator.finishDelegate = self
        loginCoordinator.start()
        
        childCoordinators.append(loginCoordinator)
    }
    
    func showAppFlow() {
        let tabCoordinator = TabCoordinator(navigationController)
        tabCoordinator.finishDelegate = self
        tabCoordinator.start()
        
        childCoordinators.append(tabCoordinator)
    }
}

// MARK: - CoordinatorFinishDelegate extension
@available(iOS 13.0, *)
extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0.type != childCoordinator.type }
        
        switch childCoordinator.type {
        case .tab:
            navigationController.viewControllers.removeAll()
            
            showLoginFlow()
        case .login:
            navigationController.viewControllers.removeAll()
            
            showAppFlow()
        default:
            break
        }
    }
}


