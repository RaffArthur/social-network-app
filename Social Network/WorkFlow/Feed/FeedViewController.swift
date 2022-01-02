//
//  FeedViewController.swift
//  Navigation
//
//

import UIKit

@available(iOS 13.0, *)
final class FeedViewController: UIViewController {
    var didSendEventClosure: ((FeedViewController.Event) -> Void)?
    private let feedContainerView = FeedContainerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedContainerView.didSendEventClosure = { [weak self] event in
            guard let self = self else { return }
            
            switch event {
            case .showPostButtonOneTapped:
                self.didSendEventClosure?(.postButtonTapped)
            case .showPostButtonTwoTapped:
                self.didSendEventClosure?(.postButtonTapped)
            }
        }
        setupScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let tabBarController = tabBarController else { return }

        tabBarController.tabBar.isHidden = false
    }
}

@available(iOS 13.0, *)
extension FeedViewController {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupContent() {
        view.backgroundColor = .white
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

@available(iOS 13.0, *)
extension FeedViewController {
    enum Event {
        case postButtonTapped
    }
}
