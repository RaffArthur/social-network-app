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
        private static let theme = UITraitCollection.current.userInterfaceStyle
        
        // MARK: - Default Colors
        static let accent = UIColor(rgba: 0, 119, 255)
        static let destructive = UIColor(rgba: 230, 70, 70)
        
        // MARK: - Background Colors
        static let mainBackground = theme == .light ? UIColor(rgba: 255, 255, 255) : UIColor(rgba: 25, 25, 25)
        static let formBackground = theme == .light ? UIColor(rgba: 242, 243, 245) : UIColor(rgba: 242, 243, 245, 0.05)
        static let primaryBackground = theme == .light ? UIColor(rgba: 45, 129, 224) : UIColor(rgba: 255, 255, 255)
        static let secondaryBackground = theme == .light ? UIColor(rgba: 0, 28, 61, 0.05) : UIColor(rgba: 255, 255, 255, 0.2)
        static let mutedBackground = UIColor(rgba: 242, 243, 245)
        static let clearBackground = UIColor(rgba: 0, 0, 0, 0)
        static let commerceBackground = UIColor(rgba: 75, 179, 75)
        static let errorBackground = UIColor(rgba: 250, 235, 235, 1)
        static let likedBackground = UIColor(rgba: 231, 54, 70, 0.2)
        static let favouriteBackground = UIColor(rgba: 0, 119, 255, 0.2)
        
        // MARK: - Foreground Colors
        static let primaryForeground = theme == .light ? UIColor(rgba: 242, 243, 245) : UIColor(rgba: 44, 45, 46)
        static let secondaryForeground = theme == .light ? UIColor(rgba: 38, 136, 235) : UIColor(rgba: 255, 255, 255)
        static let mutedForeground = UIColor(rgba: 38, 136, 235)
        static let tertiaryForeground = UIColor(rgba:45, 129, 224)
        static let commerceForeground = UIColor(rgba: 255, 255, 255)
        static let likedForeground = UIColor(rgba: 231, 54, 70, 1)
        
        // MARK: - Text Colors
        static let primaryText = theme == .light ? UIColor(rgba: 0, 0, 0) : UIColor(rgba: 225, 227, 230)
        static let secondaryText = theme == .light ? UIColor(rgba: 129, 140, 153) : UIColor(rgba: 118, 120, 122)
        static let subheadText = theme == .light ? UIColor(rgba: 109, 120, 133) : UIColor(rgba: 118, 120, 122)
        static let placeholderText = UIColor(rgba: 129, 140, 153)
        static let likedText = UIColor(rgba: 215, 78, 94)

        
        // MARK: - Border Colors
        static let mainBorder = theme == .light ? UIColor(rgba: 0, 0, 0, 0.12) : UIColor(rgba: 255, 255, 255, 0.2)
        static let errorBorder = UIColor(rgba: 230, 70, 70)
        
        // MARK: - Icon Colors
        static let tintIcon = theme == .light ? UIColor(rgba: 184, 193, 204) : UIColor(rgba: 135, 135, 135)
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat? = nil) {
        let rgbValue = CGFloat(255)
        
        self.init(red: r/rgbValue, green: g/rgbValue, blue: b/rgbValue, alpha: a ?? 1)
    }
    
    convenience init(rgba r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat? = nil) {
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
