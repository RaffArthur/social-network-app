//
//  ProfileUserQuickActionsView.swift
//  Social_Network
//
//  Created by Arthur Raff on 08.10.2023.
//

import Foundation
import UIKit

final class ProfileUserQuickActionsView: UIView {
    private lazy var createNoteLabel: UILabel = {
        let label = UILabel()
        label.text = "Запись"
        label.textAlignment = .center
        label.font = .SocialNetworkFont.subhead
        
        return label
    }()
    
    private lazy var showHistoryLabel: UILabel = {
        let label = UILabel()
        label.text = "История"
        label.textAlignment = .center
        label.font = .SocialNetworkFont.subhead
        
        return label
    }()
    
    private lazy var showPhotosLabel: UILabel = {
        let label = UILabel()
        label.text = "Фото"
        label.textAlignment = .center
        label.font = .SocialNetworkFont.subhead
        
        return label
    }()
    
    private lazy var createNoteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        button.tintColor = .SocialNetworkColor.primaryText
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        return button
    }()
    
    private lazy var showHistoryButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.tintColor = .SocialNetworkColor.primaryText
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        return button
    }()
    
    private lazy var showPhotosButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "photo"), for: .normal)
        button.tintColor = .SocialNetworkColor.primaryText
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        return button
    }()
    
    private lazy var createNoteContainer: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 8
        sv.alignment = .center
        
        return sv
    }()
    
    private lazy var showHistoryContainer: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 8
        sv.alignment = .center
        
        return sv
    }()
    
    private lazy var showPhotosContainer: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 8
        sv.alignment = .center
        
        return sv
    }()
    
    private lazy var userQuickActionsContainer: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 16
        sv.alignment = .center
        
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ProfileUserQuickActionsView {
    func setupView() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        addSubview(userQuickActionsContainer)
        
        createNoteContainer.add(arrangedSubviews: [createNoteButton,
                                                   createNoteLabel])
        
        showHistoryContainer.add(arrangedSubviews: [showHistoryButton,
                                                    showHistoryLabel])
        
        showPhotosContainer.add(arrangedSubviews: [showPhotosButton,
                                                   showPhotosLabel])
        
        userQuickActionsContainer.add(arrangedSubviews: [createNoteContainer,
                                                         showHistoryContainer,
                                                         showPhotosContainer])
        
        userQuickActionsContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        createNoteContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        showHistoryContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        showPhotosContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        createNoteButton.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
        
        showHistoryButton.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
        
        showPhotosButton.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
    }
    
    func setupContent() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        backgroundColor = .SocialNetworkColor.secondaryBackground
    }
}
