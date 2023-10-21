//
//  ProfileMenuViewController.swift
//  Social_Network
//
//  Created by Arthur Raff on 21.10.2023.
//

import Foundation
import UIKit

final class ProfileMenuViewController: UIViewController {
    weak var reviewer: AuthentificationReviewer?
    weak var delegate: ProfileMenuViewControllerDelegate?
    
    private let service = Services.userDataService()
    
    private lazy var profileMenuView = ProfileMenuView()
    private lazy var profileMenuHeaderView = ProfileMenuHeaderView()
    
    private lazy var profileMenuRows = [
        ProfileMenuModel(icon: "person", title: "Аккаунт", chevron: "chevron.right"),
        ProfileMenuModel(icon: "folder", title: "Файлы", chevron: "chevron.right"),
        ProfileMenuModel(icon: "archivebox", title: "Архивы", chevron: "chevron.right"),
        ProfileMenuModel(icon: nil, title: "Выход", chevron: nil),
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        service.getUserData { [weak self] result in
            switch result {
            case .success(let data):
                guard let name = data.name,
                      let surname = data.surname
                else {
                    return
                }
                
                self?.profileMenuHeaderView.setupUserName(userName: "\(name) \(surname)")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupContent()
        
        profileMenuView.tableView(delegate: self, dataSource: self)
        profileMenuView.tableViewReloadData()
    }
    
    override func loadView() {
        view = profileMenuView
    }
}

private extension ProfileMenuViewController {
    func setupContent() {
        view.backgroundColor = .SocialNetworkColor.mainBackground
        title = .localized(key: .profileMenuTitle)
    }
}

extension ProfileMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let profileMenuRow = profileMenuRows[indexPath.row]
        
        if profileMenuRow.title == "Выход" {
            let credentials = UserCredentials(email: nil,
                                              password: nil,
                                              repeatPassword: nil,
                                              loggedIn: false)
    
            reviewer?.signOutWith(credentials: credentials) { [weak self] result in
                switch result {
                case .success:
                    self?.delegate?.logoutRowWasTapped()
                case .failure(let error):
                    self?.show(error: error)
                }
            }
        }
        
        if profileMenuRow.title == "Аккаунт" {
            delegate?.accountRowWasTapped()
        }
    }
}

extension ProfileMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return profileMenuHeaderView
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return profileMenuRows.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: ProfileMenuTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier ,
                                                 for: indexPath) as? ProfileMenuTableViewCell
        
        
        cell?.configure(withModel: profileMenuRows[indexPath.row])
        
        return cell ?? UITableViewCell()
    }
}

private extension ProfileMenuViewController {
    func show(error: UserAuthError) {
        let alertController = UIAlertController(title: error.title,
                                                 message: error.message,
                                                 preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК",
                                   style: .cancel,
                                   handler: nil)
        
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }
}
