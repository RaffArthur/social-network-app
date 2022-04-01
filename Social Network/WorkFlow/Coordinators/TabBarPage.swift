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
    case feed
    case media
    
    init?(index: Int) {
        switch index {
        case 0:
            self = .profile
        case 1:
            self = .feed
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
        case .feed:
            return 1
        case .media:
            return 2
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .profile:
            return "Профиль"
        case .feed:
            return "Лента"
        case .media:
            return "Медиа"
        }
    }
    
    func pageIconValue() -> UIImage {
        switch self {
        case .profile:
            return UIImage(systemName: "person.fill")!
        case .feed:
            return UIImage(systemName: "house.fill")!
        case .media:
            return UIImage(systemName: "play.tv")!
        }
    }
}