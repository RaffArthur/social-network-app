//
//  TabBarPage.swift
//  Social_Network
//
//  Created by Arthur Raff on 08.10.2021.
//

import UIKit

@available(iOS 13.0, *)
enum TabBarPage: CaseIterable {    
    case profile
    case favourite
    case media
    
    init?(index: Int) {
        switch index {
        case 0:
            self = .profile
        case 1:
            self = .favourite
        case 2:
            self = .media
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
        case .media:
            return 2
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .profile:
            return "Профиль"
        case .favourite:
            return "Избранное"
        case .media:
            return "Медиа"
        }
    }
    
    func pageIconValue() -> UIImage {
        switch self {
        case .profile:
            return UIImage(systemName: "person.fill")!
        case .favourite:
            return UIImage(systemName: "heart.text.square.fill")!
        case .media:
            return UIImage(systemName: "play.tv")!
        }
    }
}
