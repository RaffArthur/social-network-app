//
//  MainProfileInfoViewController.swift
//  Social_Network
//
//  Created by Arthur Raff on 15.10.2023.
//

import Foundation
import UIKit

final class MainProfileInfoViewController: UIViewController {
    weak var delegate: MainProfileInfoViewControllerDelegate?
    
    private lazy var mainProfileInfoView = MainProfileInfoView()
    
    private lazy var cancelProfileInfoButton: UIBarButtonItem = {
        let bbi = UIBarButtonItem()
        bbi.image = UIImage(systemName: "xmark")
        bbi.tintColor = .SocialNetworkColor.accent
        
        return bbi
    }()
    
    private lazy var saveProfileInfoButton: UIBarButtonItem = {
        let bbi = UIBarButtonItem()
        bbi.image = UIImage(systemName: "checkmark")
        bbi.tintColor = .SocialNetworkColor.accent
        
        return bbi
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupContent()
        setupActions()
        
        mainProfileInfoView.delegate = self
    }
    
    override func loadView() {
        view = mainProfileInfoView
    }
}

private extension MainProfileInfoViewController {
    func setupContent() {
        view.backgroundColor = .SocialNetworkColor.mainBackground
        title = .localized(key: .mainProfileInfoVcTitle)
        
        navigationItem.leftBarButtonItem = cancelProfileInfoButton
        navigationItem.rightBarButtonItem = saveProfileInfoButton
    }
}

private extension MainProfileInfoViewController {
    @objc func cancelProfileInfoButtonWasTapped() {
        delegate?.cancelProfileInfoButtonWasTapped()
    }
    
    @objc func saveProfileInfoButtonWasTapped() {
        delegate?.saveProfileInfoButtonWasTapped()
    }
    
    func setupActions() {
        cancelProfileInfoButton.action = #selector(cancelProfileInfoButtonWasTapped)
        cancelProfileInfoButton.target = self
        
        saveProfileInfoButton.action = #selector(saveProfileInfoButtonWasTapped)
        saveProfileInfoButton.target = self
    }
}

extension MainProfileInfoViewController: MainProfileInfoViewDelegate {
    func birthDateWillBeSaved(date: Date) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
        
        guard let day = components.day,
              let month = components.month,
              let year = components.year
        else {
            return
        }
                
        mainProfileInfoView.userBirthDate = "\(day).\(month).\(year)"
    }
}
