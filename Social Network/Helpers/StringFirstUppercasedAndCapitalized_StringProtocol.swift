//
//  StringFirstUppercasedAndCapitalized.swift
//  Social_Network
//
//  Created by Arthur Raff on 16.08.2021.
//

import UIKit

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}
