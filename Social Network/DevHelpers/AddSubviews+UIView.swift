//
//  AddSubviews+UIView.swift
//  Social_Network
//
//  Created by Arthur Raff on 02.01.2022.
//

import UIKit

extension UIView {
    func add(subviews: [UIView]) {
        subviews.forEach { self.addSubview($0) }
    }
}
