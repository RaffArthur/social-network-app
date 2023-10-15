//
//  MainProfileInfoViewController.swift
//  Social_Network
//
//  Created by Arthur Raff on 15.10.2023.
//

import Foundation
import UIKit

final class MainProfileInfoViewController: UIViewController {
    private lazy var mainProfileInfoView = MainProfileInfoView()
    
    private lazy var cancelProfileInfoBarButton: UIBarButtonItem = {
        let bbi = UIBarButtonItem()
        bbi.image = UIImage(systemName: "xmark")
        bbi.tintColor = .SocialNetworkColor.accent
        
        return bbi
    }()
    
    private lazy var saveProfileInfoBarButton: UIBarButtonItem = {
        let bbi = UIBarButtonItem()
        bbi.image = UIImage(systemName: "checkmark")
        bbi.tintColor = .SocialNetworkColor.accent
        
        return bbi
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupContent()
    }
    
    override func loadView() {
        view = mainProfileInfoView
    }
}

private extension MainProfileInfoViewController {
    func setupContent() {
        view.backgroundColor = .SocialNetworkColor.mainBackground
        navigationController?.title = .localized(key: .mainProfileInfoVcTitle)
        
        navigationItem.leftBarButtonItem = cancelProfileInfoBarButton
        navigationItem.rightBarButtonItem = saveProfileInfoBarButton
    }
}
