//
//  TabBarViewController.swift
//  Navigation
//
//  Created by Arthur Raff on 12.10.2020.
//

import UIKit

@available(iOS 13.0, *)
class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    weak var coordinator: TabBarCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        coordinator?.start()
        
        self.delegate = self
    }
}


