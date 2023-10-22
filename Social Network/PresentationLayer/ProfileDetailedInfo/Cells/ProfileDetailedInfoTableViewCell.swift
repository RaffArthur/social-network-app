//
//  ProfileDetailedInfoTableViewCell.swift
//  Social_Network
//
//  Created by Arthur Raff on 22.10.2023.
//

import Foundation
import UIKit

final class ProfileDetailedInfoTableViewCell: UITableViewCell {
    private lazy var detailedInfoIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .SocialNetworkColor.secondaryText
        iv.contentMode = .scaleAspectFit

        return iv
    }()
    
    private lazy var detailedInfoTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .SocialNetworkFont.text
        label.textColor = .SocialNetworkColor.secondaryText
        
        return label
    }()
    
    private lazy var detailedInfoContainer: UIStackView = {
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
}
extension ProfileDetailedInfoTableViewCell {
    func configure(withModel: ProfileDetailedInfoMenuModel) {
        if let icon = withModel.icon {
            detailedInfoIconImageView.image = UIImage(systemName: icon)
        } else {
            detailedInfoIconImageView.isHidden = true
        }
        
        if let description = withModel.description {
            if description.contains(String.localized(key: .mainProfileInfoRegaliaTitle)) {
                detailedInfoTitleLabel.textColor = .SocialNetworkColor.primaryText
            }
            
            if description.contains("@") {
                detailedInfoTitleLabel.textColor = .SocialNetworkColor.accent
            }
            
            detailedInfoTitleLabel.text = description
        } else {
            detailedInfoIconImageView.isHidden = true
        }
    }
}

private extension ProfileDetailedInfoTableViewCell {
    func setupCell() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        addSubview(detailedInfoContainer)
        
        detailedInfoContainer.add(arrangedSubviews: [detailedInfoIconImageView,
                                                     detailedInfoTitleLabel])
        
        detailedInfoContainer.setCustomSpacing(10, after: detailedInfoIconImageView)
        
        detailedInfoContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        detailedInfoIconImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.leading.top.bottom.equalToSuperview()
        }
        
        detailedInfoTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(detailedInfoIconImageView)
        }
    }
    
    func setupContent() {
        backgroundColor = .SocialNetworkColor.mainBackground
    }
}
