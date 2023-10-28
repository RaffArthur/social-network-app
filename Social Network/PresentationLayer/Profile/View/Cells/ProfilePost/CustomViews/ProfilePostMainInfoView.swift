//
//  ProfilePostMainInfoView.swift
//  Social_Network
//
//  Created by Arthur Raff on 23.10.2023.
//

import Foundation
import UIKit

final class ProfilePostMainInfoView: UIView {
    private lazy var postTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .SocialNetworkFont.t3
        label.textColor = .SocialNetworkColor.primaryText
        label.numberOfLines = 2
        label.lineBreakMode = .byClipping
        
        return label
    }()
    
    private lazy var postDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .SocialNetworkFont.text
        label.textColor = .SocialNetworkColor.primaryText
        label.numberOfLines = 0
        
        return label
    }()

    private lazy var postPhoto: UIImageView = {
        let iv = UIImageView()
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 18
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .SocialNetworkColor.accent
        iv.tintColor = .white
        
        return iv
    }()
    
    private lazy var postMainInfoContainer: UIStackView = {
        let sv = UIStackView()
        sv.alignment = .fill
        sv.distribution = .fill
        sv.axis = .vertical
        sv.spacing = 8
        
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfilePostMainInfoView {
    func configurePostMainInfo(title: String?, description: String, image: String?) {
        if let title = title {
            postTitleLabel.text = title
        } else {
            postTitleLabel.isHidden = true
        }
        
        postDescriptionLabel.text = description
        
        if let image = image {
            postPhoto.image = UIImage(systemName: image)
        } else {
            postPhoto.isHidden = true
        }
    }
}

private extension ProfilePostMainInfoView {
    func setupLayout() {
        addSubview(postMainInfoContainer)
        
        postMainInfoContainer.add(arrangedSubviews: [postTitleLabel,
                                                     postDescriptionLabel,
                                                     postPhoto])
                
        postMainInfoContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        postPhoto.snp.makeConstraints { make in
            make.height.equalTo(125)
        }
    }
}
