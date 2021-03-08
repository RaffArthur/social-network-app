//
//  FeedViewController.swift
//  Navigation
//
//

import UIKit

@available(iOS 13.0, *)
final class FeedViewController: UIViewController {
    
    // MARK: - Properties
    weak var coordinator: FeedCoordinator?

    private let feedContainerView = FeedContainerView()
    
    // MARK: - View Funcs
    private func setupLayout() {
        view.addSubview(feedContainerView)
        
        feedContainerView.snp.makeConstraints { (make) in
            make.width.equalTo(view.snp.width).multipliedBy(0.96)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(view.safeAreaLayoutGuide.snp.centerY)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Feed"
                
        feedContainerView.onTap = { [weak self] in
            self?.coordinator?.showPost()
        }
                                
        setupLayout()
    }
}
