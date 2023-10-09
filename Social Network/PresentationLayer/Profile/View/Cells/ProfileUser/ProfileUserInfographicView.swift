//
//  ProfileUserInfographicView.swift
//  Social_Network
//
//  Created by Arthur Raff on 08.10.2023.
//

import Foundation
import UIKit

final class ProfileUserInfographicView: UIView {
    private lazy var userInfographicContainer: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 16
        sv.alignment = .center

        return sv
    }()
    
    private lazy var userPublications: UILabel = {
        let label = UILabel()
        label.text = "210 \n публикаций"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .medium)
        
        return label
    }()
    
    private lazy var userSubscriptions: UILabel = {
        let label = UILabel()
        label.text = "523 \n подписок"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .medium)
        
        return label
    }()
    
    private lazy var userSubscribers: UILabel = {
        let label = UILabel()
        label.text = "47 \n подписчиков"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .medium)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ProfileUserInfographicView {
    func setupView() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        addSubview(userInfographicContainer)
        
        userInfographicContainer.add(arrangedSubviews: [userPublications,
                                                         userSubscriptions,
                                                         userSubscribers])
        
        userInfographicContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupContent() {
        backgroundColor = .clear
    }
}
