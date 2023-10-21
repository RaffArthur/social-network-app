//
//  ProfileMenuViewController.swift
//  Social_Network
//
//  Created by Arthur Raff on 21.10.2023.
//

import Foundation
import UIKit

final class ProfileMenuViewController: UIViewController {
    private lazy var profileMenuView = ProfileMenuView()
    
    private lazy var profileMenuRows = [
        ProfileMenuModel(icon: "person", title: "Аккаунт", chevron: "chevron.right"),
        ProfileMenuModel(icon: "bookmark", title: "Избранное", chevron: "chevron.right"),
        ProfileMenuModel(icon: nil, title: "Выход", chevron: nil),
    ]
    
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
}

extension ProfileMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return profileMenuRows.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: ProfileMenuTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier ,
                                                 for: indexPath) as? ProfileMenuTableViewCell
        
        cell?.selectionStyle = .gray
        
        cell?.configure(withModel: profileMenuRows)
        
        return cell ?? UITableViewCell()
    }
}
