//
//  FeedViewController.swift
//  Navigation
//
//

import UIKit

final class FavouriteViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
    }
}

private extension FavouriteViewController {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupContent() {
        view.backgroundColor = .white
    }
    
    func setupLayout() {
        
    }
}
