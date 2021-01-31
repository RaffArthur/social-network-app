//
//  FeedContainerView.swift
//  Social_Network
//
//  Created by Arthur Raff on 14.01.2021.
//

import UIKit

class FeedContainerView: UIStackView {
    // MARK: - Properties
    public var onTap: (() -> Void)?
    private lazy var showPostButtonOne: UIButton = {
        let button = UIButton()
        button.setTitle("Post Button One".uppercased(), for: button.state)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .black)
        button.backgroundColor = UIColor(named: "color_set")
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.isEnabled = true

        return button
    }()
    private lazy var showPostButtonTwo: UIButton = {
        let button = UIButton()
        button.setTitle("Post Button Two".uppercased(), for: button.state)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .black)
        button.backgroundColor = UIColor(named: "color_set")
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.isEnabled = true
        
        return button
    }()
    
    // MARK: - View Funcs
    private func setupLayout() {
        addSubview(showPostButtonOne)
        addSubview(showPostButtonTwo)
        
        showPostButtonOne.snp.makeConstraints { (make) in
            make.height.equalTo(56)
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(showPostButtonTwo.snp.top).offset(-24)
        }
        
        showPostButtonTwo.snp.makeConstraints { (make) in
            make.height.equalTo(56)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupLayout()
    }
    
    // MARK: - @objc actions
    @objc func buttonPressed(sender: UIButton!) {
        onTap?()
    }
}
