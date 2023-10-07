//
//  FavouriteView.swift
//  Social_Network
//
//  Created by Arthur Raff on 07.10.2023.
//

import Foundation
import UIKit

final class FavouriteView: UIView {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(ProfilePostTableViewCell.self,
                           forCellReuseIdentifier: String(describing: ProfilePostTableViewCell.self))
        tableView.showsVerticalScrollIndicator = false
                
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setuScreen()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavouriteView {
    func tableViewReloadData() {
        tableView.reloadData()
    }
    
    func tableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    
    func tableViewDeleteRowsAt(indexPath: [IndexPath], withAnimation: UITableView.RowAnimation) {
        tableView.deleteRows(at: indexPath, with: withAnimation)
    }
    
    func getTableViewTouchPointIndexPath(sender: UITapGestureRecognizer) -> IndexPath {
        let touchPoint = sender.location(in: tableView)
        
        guard let indexPath = tableView.indexPathForRow(at: touchPoint) else { return IndexPath() }
        
        return indexPath
    }
}

private extension FavouriteView {
    func setuScreen() {
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
        backgroundColor = .systemBackground
    }
}
