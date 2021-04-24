//
//  URLsDomain.swift
//  Social_Network
//
//  Created by Arthur Raff on 13.04.2021.
//

import UIKit

enum AppConfiguration: CaseIterable, Equatable {
    static var allCases: [AppConfiguration] {
        return [.URLOne(""), .URLTwo(""), .URLThree("")]
    }
    
    case URLOne(String)
    case URLTwo(String)
    case URLThree(String)
}
