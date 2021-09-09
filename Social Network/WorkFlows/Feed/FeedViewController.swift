//
//  FeedViewController.swift
//  Navigation
//
//

import UIKit

@available(iOS 13.0, *)
final class FeedViewController: UIViewController {
    weak var coordinator: FeedCoordinator?
    private let feedContainerView = FeedContainerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedContainerView.onTap = { [weak self] in
            self?.coordinator?.showPost()
        }
                                
        setupScreen()
    }
}

@available(iOS 13.0, *)
extension FeedViewController: ScreenSetupper {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupContent() {
        view.backgroundColor = .white
        title = "Feed"
    }
    
    func setupLayout() {
        view.addSubview(feedContainerView)
        
        feedContainerView.snp.makeConstraints { (make) in
            make.width.equalTo(view.snp.width).multipliedBy(0.96)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(view.safeAreaLayoutGuide.snp.centerY)
        }
    }
}
