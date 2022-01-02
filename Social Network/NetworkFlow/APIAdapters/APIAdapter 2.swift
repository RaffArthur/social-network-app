//
//  APIAdapter.swift
//  Social_Network
//
//  Created by Arthur Raff on 17.08.2021.
//

import UIKit

public protocol APIAdapter {
    func receiveData(from url: URL?)
    func setupData()
}
