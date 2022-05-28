//
//  CoreDataManager.swift
//  Social_Network
//
//  Created by Arthur Raff on 28.05.2022.
//

import Foundation

protocol CoreDataManager: AnyObject {
    func load(completion: (() -> Void)?)
}
