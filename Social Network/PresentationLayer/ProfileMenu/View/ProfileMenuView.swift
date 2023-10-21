//
//  ProfileMenuView.swift
//  Social_Network
//
//  Created by Arthur Raff on 21.10.2023.
//

import Foundation
import UIKit

final class ProfileMenuView: UIView {
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.register(ProfileMenuTableViewCell.self,
                    forCellReuseIdentifier: String(describing: ProfileMenuTableViewCell.self))
        tv.showsVerticalScrollIndicator = true
        tv.separatorStyle = .none
        tv.backgroundColor = .SocialNetworkColor.mainBackground
        
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileMenuView {
    func tableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    
    func tableViewReloadData() {
        tableView.reloadData()
    }
}

private extension ProfileMenuView {
    func setupView() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview {
                $0.safeAreaLayoutGuide
            }
        }
    }
    
    func setupContent() {
        backgroundColor = .SocialNetworkColor.mainBackground
    }
}
