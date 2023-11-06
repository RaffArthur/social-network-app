//
//  PostCommentsHeaderView.swift
//  Social_Network
//
//  Created by Arthur Raff on 04.11.2023.
//

import Foundation
import UIKit

final class PostCommentsHeaderView: UIView {
    private lazy var commentsCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .SocialNetworkColor.secondaryText
        label.font = .SocialNetworkFont.subhead
        label.textAlignment = .left
        
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

private extension PostCommentsHeaderView {
    func setupView() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        addSubview(commentsCountLabel)
        
        commentsCountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    func setupContent() {
        backgroundColor = .SocialNetworkColor.mainBackground
    }
}

extension PostCommentsHeaderView {
    func configure(commentsCount: String) {
        commentsCountLabel.text = commentsCount
    }
}
