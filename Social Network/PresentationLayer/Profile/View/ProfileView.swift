//
//  ProfileView.swift
//  Social_Network
//
//  Created by Arthur Raff on 07.10.2023.
//

import Foundation
import UIKit

final class ProfileView: UIView {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(ProfilePostTableViewCell.self,
                           forCellReuseIdentifier: String(describing: ProfilePostTableViewCell.self))
        tableView.register(ProfilePhotosPreviewTableViewCell.self,
                           forCellReuseIdentifier: String(describing: ProfilePhotosPreviewTableViewCell.self))
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .SocialNetworkColor.clearBackground
        tableView.separatorColor = .SocialNetworkColor.secondaryBackground
        tableView.separatorInsetReference = .fromCellEdges
                
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupScreen()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileView {
    func tableViewReloadData() {
        tableView.reloadData()
    }
    
    func tableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    
    func tableViewIndexPath(sender: UIButton) -> IndexPath {
        var superView = sender.superview
        
        while !(superView is UITableViewCell) {
            superView = superView?.superview
        }
        
        let cell = superView as! UITableViewCell
                
        guard let indexPath = tableView.indexPath(for: cell) else { return IndexPath() }
        
        return indexPath
    }
}

private extension ProfileView {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview {
                $0.safeAreaLayoutGuide.snp.edges
            }
        }
    }
    
    func setupContent() {
        backgroundColor = .SocialNetworkColor.clearBackground
    }
}
