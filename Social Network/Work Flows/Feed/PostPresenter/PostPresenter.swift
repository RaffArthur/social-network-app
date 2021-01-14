//
//  PostPresenter.swift
//  Social_Network
//
//  Created by Arthur Raff on 14.01.2021.
//

import UIKit

class PostPresenter: FeedViewOutput {
    var navigationController: UINavigationController?

    func showPost() {
        let postVC = PostViewController()
        navigationController?.pushViewController(postVC, animated: true)
    }
}
