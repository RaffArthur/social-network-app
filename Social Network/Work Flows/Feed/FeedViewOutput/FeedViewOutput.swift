//
//  FeedViewOutput.swift
//  Social_Network
//
//  Created by Arthur Raff on 14.01.2021.
//

import UIKit

protocol FeedViewOutput: class {
    var navigationController: UINavigationController? { get set }
    
    func showPost()
}
