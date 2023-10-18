//
//  MainProfileInfoViewController.swift
//  Social_Network
//
//  Created by Arthur Raff on 15.10.2023.
//

import Foundation
import UIKit

final class MainProfileInfoViewController: UIViewController {
    private let service = Services.userDataService()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        service.getUserData { [weak self] result in
            switch result {
            case .success(let result):
                guard let name = result.name,
                      let surname = result.surname,
                      let regalia = result.regalia,
                      let birthDate = result.birthDate,
                      let hometown = result.hometown,
                      let gender = result.gender
                else {
                    return
                }
                
                self?.mainProfileInfoView.setupUserMainInfoFields(userName: name,
                                                                 userSurname: surname,
                                                                 userRegalia: regalia,
                                                                 userBirthDate: birthDate,
                                                                 userHometown: hometown,
                                                                 userGender: gender)
            case .failure(let error):
                self?.show(userMainProfileInfoErrorAlert: error)
            }
        }
    }
    
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
        service.saveUserData(userData: mainProfileInfoView.getUserMainInfo()) { [weak self] result in
            switch result {
            case .success:
                self?.delegate?.saveProfileInfoButtonWasTapped()
            case .failure(let error):
                self?.show(userMainProfileInfoErrorAlert: error)
            }
        }
    }
    
    func setupActions() {
        cancelProfileInfoButton.action = #selector(cancelProfileInfoButtonWasTapped)
        cancelProfileInfoButton.target = self
        
        saveProfileInfoButton.action = #selector(saveProfileInfoButtonWasTapped)
        saveProfileInfoButton.target = self
    }
}

private extension MainProfileInfoViewController {
    func show(userMainProfileInfoErrorAlert: UserMainProfileInfoError) {
        let alertController = UIAlertController(title: userMainProfileInfoErrorAlert.title,
                                                message: userMainProfileInfoErrorAlert.message,
                                                preferredStyle: .alert)
        
        let action = UIAlertAction(title: "ОК",
                                   style: .cancel,
                                   handler: nil)
        
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
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
