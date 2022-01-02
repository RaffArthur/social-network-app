//
//  TabCoordinator.swift
//  Social_Network
//
//  Created by Arthur Raff on 09.02.2021.
//

import UIKit

@available(iOS 13.0, *)
protocol TabCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get set }
    
    func selectPage(_ page: TabBarPage)
    func selectedIndex(_ index: Int)
    func currentPage() -> TabBarPage?
}

@available(iOS 13.0, *)
class TabCoordinator: NSObject, TabCoordinatorProtocol {
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
        let pages = TabBarPage.allCases.sorted { $0.pageOrderNumber() < $1.pageOrderNumber() }
        let controllers: [UINavigationController] = pages.map { getTabController($0) }
        
        prepareTabBarController(withTabControllers: controllers)
    }
    
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.delegate = self
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPage.profile.pageOrderNumber()
        tabBarController.tabBar.isTranslucent = true
        
        navigationController.viewControllers = [tabBarController]
    }
    
    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: true)
        navController.tabBarItem = UITabBarItem(title: page.pageTitleValue(),
                                                image: page.pageIconValue(),
                                                tag: page.pageOrderNumber())
        
        switch page {
        case .profile:
            showProfileFlow(navController: navController)
        case .feed:
            showFeedFlow(navController: navController)
        case .media:
            break
        }
        
        return navController
    }

    func currentPage() -> TabBarPage? {
        TabBarPage(index: tabBarController.selectedIndex)
    }
    
    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    func selectedIndex(_ index: Int) {
        guard let page = TabBarPage(index: index) else { return }

        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    func showProfileFlow(navController: UINavigationController) {
        let profileCoordinator = ProfileCoordinator(navController)
        profileCoordinator.start()
        
        profileCoordinator.logOutted = { [weak self] in
            guard let self = self else { return }
            
            self.finish()
        }
        
        childCoordinators.append(profileCoordinator)
    }

    func showFeedFlow(navController: UINavigationController) {
        let feedCoordinator = FeedCoordinator(navController)
        feedCoordinator.start()
        
        childCoordinators.append(feedCoordinator)
    }
}

@available(iOS 13.0, *)
extension TabCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
}
