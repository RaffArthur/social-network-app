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
        iv.contentMode = .scaleAspectFit

        return iv
    }()
    
    private lazy var menuTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .SocialNetworkFont.headlineMedium
        label.textColor = .SocialNetworkColor.primaryText
        
        return label
    }()
    
    private lazy var menuChevron: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .SocialNetworkColor.tintIcon
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()
    
    private lazy var menuContainer: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .center
        sv.distribution = .fillProportionally
        
        return sv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        menuIconImageView.isHidden = false
        menuTitleLabel.isHidden = false
        menuChevron.isHidden = false
        menuIconImageView.image = .none
        menuIconImageView.tintColor = .none
        menuTitleLabel.text = .none
        menuTitleLabel.textColor = .none
        menuChevron.image = .none
    }
}

private extension ProfileMenuTableViewCell {
    func setupCell() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        menuContainer.add(arrangedSubviews: [menuIconImageView,
                                             menuTitleLabel,
                                             menuChevron])
        
        addSubview(menuContainer)
        
        menuContainer.setCustomSpacing(8, after: menuIconImageView)
        
        menuContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        menuIconImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        menuTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(menuIconImageView)
        }
        
        menuChevron.snp.makeConstraints { make in
            make.size.equalTo(16)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(menuIconImageView)
        }
    }
    
    func setupContent() {
        backgroundColor = .SocialNetworkColor.mainBackground
    }
}

extension ProfileMenuTableViewCell {
    func configure(withModel: ProfileMenuModel) {
        if let icon = withModel.icon {
            menuIconImageView.image = UIImage(systemName: icon)
        } else {
            menuIconImageView.isHidden = true
        }
        
        if let title = withModel.title {
            if title.contains("Выход") {
                menuTitleLabel.textColor = .SocialNetworkColor.destructive
            }
            
            menuTitleLabel.text = title
        } else {
            menuTitleLabel.isHidden = true
        }
        
        if let chevron = withModel.chevron {
            menuChevron.image = UIImage(systemName: chevron)
        } else {
            menuChevron.isHidden = true
        }
    }
}
