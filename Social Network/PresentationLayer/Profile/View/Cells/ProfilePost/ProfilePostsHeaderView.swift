//
//  ProfilePostsHeaderView.swift
//  Social_Network
//
//  Created by Arthur Raff on 20.10.2023.
//

import Foundation
import UIKit

final class ProfilePostsHeaderView: UIView {
    private lazy var myPostsLabel: UILabel = {
        var label = UILabel()
        label.font = .SocialNetworkFont.headlineMedium
        label.textAlignment = .left
        label.text = "Мои Записи"
        label.textColor = .SocialNetworkColor.primaryText
        
        return label
    }()
    private lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        return sb
    }()
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .SocialNetworkColor.tintIcon
        button.inputView?.addSubview(searchBar)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ProfilePostsHeaderView {
    func setupView() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        add(subviews: [myPostsLabel,
                       searchButton])
        
        myPostsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        searchButton.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(myPostsLabel)
        }
    }
    
    func setupContent() {
        backgroundColor = .SocialNetworkColor.clearBackground
    }
}
