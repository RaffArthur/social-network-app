//
//  TabCoordinator.swift
//  Social_Network
//
//  Created by Arthur Raff on 09.02.2021.
//

import UIKit

final class TabCoordinator: NSObject, Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var tabBarController: UITabBarController
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .tab }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
    }
    
    func start() {
        prepareTabBarController()
    }
}

private extension TabCoordinator {
    func prepareTabBarController() {
        let controllers = TabBarPage.allCases.sorted {
            $0.pageOrderNumber() < $1.pageOrderNumber()
        }.map {
            getTabController(page: $0)
        }
        
        tabBarController.setViewControllers(controllers, animated: true)
        tabBarController.selectedIndex = TabBarPage.profile.pageOrderNumber()
        tabBarController.tabBar.isTranslucent = true
        
        navigationController.viewControllers = [tabBarController]
    }
    
    func getTabController(page: TabBarPage) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(false, animated: true)
        navigationController.tabBarItem = UITabBarItem(title: page.pageTitleValue(),
                                                image: page.pageIconValue(),
                                                tag: page.pageOrderNumber())
        
        switch page {
        case .profile:
            showProfileFlow(navigationController: navigationController)
        case .favourite:
            showFavouriteFlow(navigationController: navigationController)
        case .map:
            showMapFlow(navigationController: navigationController)
        }
        
        return navigationController
    }
    
    func showProfileFlow(navigationController: UINavigationController) {
        let coordinator = ProfileCoordinator(navigationController)
        coordinator.start()
        
        coordinator.logOutted = { [weak self] in
            self?.finish()
        }
                
        childCoordinators.append(coordinator)
    }

    func showFavouriteFlow(navigationController: UINavigationController) {
        let coordinator = FavouriteCoordinator(navigationController)
        coordinator.start()
        
        childCoordinators.append(coordinator)
    }
    
    func showMapFlow(navigationController: UINavigationController) {
        let coordinator = MapCoordinator(navigationController)
        coordinator.start()
        
        childCoordinators.append(coordinator)
    }
}
