//
//  UIViewToAutoLayout.swift
//  Navigation
//
//  Created by Arthur Raff on 12.10.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

// MARK: - AutoLayout
extension UIView {
    func toAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

