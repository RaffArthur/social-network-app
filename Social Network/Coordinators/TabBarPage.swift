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
    
    init?(index: Int) {
        switch index {
        case 0:
            self = .profile
        case 1:
            self = .favourite
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
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .profile:
            return .localized(key: .profileTab)
        case .favourite:
            return .localized(key: .favouriteTab)
        }
    }
    
    func pageIconValue() -> UIImage {
        switch self {
        case .profile:
            return UIImage(systemName: "person.fill")!
        case .favourite:
            return UIImage(systemName: "heart.text.square.fill")!
        }
    }
}
