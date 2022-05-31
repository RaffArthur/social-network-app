//
//  UIColor+SocialNetwork.swift
//  Social_Network
//
//  Created by Arthur Raff on 31.05.2022.
//

import Foundation
import UIKit

extension UIColor {
    enum SocialNetworkColor {
        case accent
        case mainText
        case secondaryText
        
        func set() -> UIColor {
            let deviceTheme = UITraitCollection.current.userInterfaceStyle

            switch self {
            case .accent:
                return UIColor(r: 85, g: 133, b: 198)
            case .mainText:
                return deviceTheme == .dark ? UIColor(r: 220, g: 220, b: 230) : UIColor(r: 36, g: 36, b: 36)
            case .secondaryText:
                return deviceTheme == .dark ? UIColor(r: 80, g: 85, b: 90) : UIColor(r: 138, g: 142, b: 138)
            }
        }
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat? = nil) {
        let rgbValue = CGFloat(255)
        
        self.init(red: r/rgbValue, green: g/rgbValue, blue: b/rgbValue, alpha: a ?? 1)
    }
}

extension UIColor {
    convenience init?(hex: String) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if (cString.count) != 6 {
            return nil
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
 
        self.init(r: CGFloat((rgbValue & 0xFF0000) >> 16),
                  g: CGFloat((rgbValue & 0x00FF00) >> 8),
                  b: CGFloat(rgbValue & 0x0000FF),
                  a: CGFloat(1.0))
    }
}
