//
//  AddArrangedSubviews+UIStackView.swift
//  Social_Network
//
//  Created by Arthur Raff on 02.01.2022.
//

import UIKit

extension UIStackView {
    func add(arrangedSubviews: [UIView]) {
        arrangedSubviews.forEach { self.addArrangedSubview($0) }
    }
}
