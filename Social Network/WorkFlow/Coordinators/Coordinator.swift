//
//  Coordinator.swift
//  Social_Network
//
//  Created by Arthur Raff on 08.10.2021.
//

import UIKit

// MARK: - Coordinator
/// Базовый протокол координатора
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

// MARK: - CoordinatorOutput
/// Протокол делегата, помогающий родительскому координатору узнать, когда его дочерний элемент готов к завершению.
protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}

// MARK: - CoordinatorType
/// Используя эту структуру, мы можем определить, какой тип потока мы можем использовать в приложении.
enum CoordinatorType {
    case app, login, tab, profile, feed, photos, post
}

