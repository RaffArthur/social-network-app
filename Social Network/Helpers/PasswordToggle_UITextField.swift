//
//  PasswordToggle_UITextField.swift
//  Social_Network
//
//  Created by Arthur Raff on 16.10.2021.
//

import UIKit

@available(iOS 13.0, *)
extension UITextField {
    private func setPasswordToggleImage(_ button: UIButton) {
        if isSecureTextEntry {
            button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        } else {
            button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)

        }
    }
    
    func enablePasswordToggle() {
        let button = UIButton(type: .custom)
        setPasswordToggleImage(button)
        
        button.tintColor = .systemGray
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(self.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
        
        self.rightView = button
        self.leftView = UIView(frame: CGRect( x: 0, y: 0, width: 10, height: self.frame.height))
        self.rightViewMode = .whileEditing
        self.leftViewMode = .always
        
    }
    
    @objc private func togglePasswordView(_ sender: Any) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        setPasswordToggleImage(sender as! UIButton)
    }
}
