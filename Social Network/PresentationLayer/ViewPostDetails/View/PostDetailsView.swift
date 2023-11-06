//
//  PostDetailsView.swift
//  Social_Network
//
//  Created by Arthur Raff on 04.11.2023.
//

import Foundation
import UIKit

final class PostDetailsView: UIView {
    weak var delegate: PostDetailsViewDelegate?
    
    private lazy var commentPanelView = PostCommentPanelView()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(ProfilePostTableViewCell.self,
                           forCellReuseIdentifier: String(describing: ProfilePostTableViewCell.self))
        tableView.register(PostCommentsTableViewCell.self,
                           forCellReuseIdentifier: String(describing: PostCommentsTableViewCell.self))
        tableView.backgroundColor = .SocialNetworkColor.clearBackground
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        
        commentPanelView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PostDetailsView {
    func tableViewReloadData() {
        tableView.reloadData()
    }
    
    func tableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
}

private extension PostDetailsView {
    func setupView() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        add(subviews: [tableView,
                       commentPanelView])
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview {
                $0.safeAreaLayoutGuide
            }
            
            make.bottom.equalTo(commentPanelView.snp.top)
        }
        
        commentPanelView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview {
                $0.safeAreaLayoutGuide
            }
        }
    }
    
    func setupContent() {
        backgroundColor = .SocialNetworkColor.clearBackground
    }
}

extension PostDetailsView: PostCommentPanelViewDelegate {
    func sendCommentButtonWasTapped(withText: String) {
        delegate?.sendCommentButtonWasTapped(withText: withText)
    }
}
