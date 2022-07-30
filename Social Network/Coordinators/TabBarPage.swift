//
//  TabBarPage.swift
//  Social_Network
//
//  Created by Arthur Raff on 08.10.2021.
//

import UIKit

enum TabBarPage: CaseIterable {    
    case profile
    case favourite
    case map
    
    init?(index: Int) {
        switch index {
        case 0:
            self = .profile
        case 1:
            self = .favourite
        case 2:
            self = .map
        default:
            return nil
        }
    }
    
    func pageOrderNumber() -> Int {
        switch self {
        case .profile:
            return 0
        case .favourite:
            return 1
        case .map:
            return 2
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .profile:
            return "Профиль"
        case .favourite:
            return "Избранное"
        case .map:
            return "Карта"
        }
    }
    
    func pageIconValue() -> UIImage {
        switch self {
        case .profile:
            return UIImage(systemName: "person.fill")!
        case .favourite:
            return UIImage(systemName: "heart.text.square.fill")!
        case .map:
            return UIImage(systemName: "map")!
        }
    }
}
