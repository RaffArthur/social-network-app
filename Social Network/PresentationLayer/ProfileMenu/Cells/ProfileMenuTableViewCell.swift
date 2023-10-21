//
//  ProfileMenuTableViewCell.swift
//  Social_Network
//
//  Created by Arthur Raff on 21.10.2023.
//

import Foundation
import UIKit

final class ProfileMenuTableViewCell: UITableViewCell {
    private lazy var menuIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .SocialNetworkColor.accent
        
        return iv
    }()
    
    private lazy var menuTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .SocialNetworkFont.t1
        label.textColor = .SocialNetworkColor.primaryText
        
        return label
    }()
    
    private lazy var menuChevron: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .SocialNetworkColor.tintIcon
        
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ProfileMenuTableViewCell {
    func setupCell() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        add(subviews: [menuIconImageView,
                       menuTitleLabel,
                       menuChevron])
        
        menuIconImageView.snp.makeConstraints { make in
            make.size.equalTo(36)
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        menuTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(menuIconImageView.snp.trailing).offset(8)
            make.centerX.equalTo(menuIconImageView)
        }
        
        menuChevron.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.trailing.equalToSuperview().offset(-8)
            make.centerX.equalTo(menuIconImageView)
        }
    }
    
    func setupContent() {
        
    }
}

extension ProfileMenuTableViewCell {
    func configure(withModel: [ProfileMenuModel]) {
        withModel.forEach {
            guard let icon = $0.icon,
                  let title = $0.title,
                  let chevron = $0.chevron
            else {
                return
            }
            
            menuIconImageView.image = UIImage(named: icon)
            menuTitleLabel.text = title
            menuChevron.image = UIImage(named: chevron)
        }
    }
}
