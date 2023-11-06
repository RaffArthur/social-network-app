//
//  PostCommentPanelView.swift
//  Social_Network
//
//  Created by Arthur Raff on 05.11.2023.
//

import Foundation
import UIKit

final class PostCommentPanelView: UIView {
    weak var delegate: PostCommentPanelViewDelegate?
    
    private var commentText: String {
        guard let text = commentField.text else { return String() }
        
        return text
    }
    
    private lazy var commentField: UITextField = {
        let tf = UITextField()
        tf.contentVerticalAlignment = .center
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.backgroundColor = .SocialNetworkColor.formBackground
        tf.font = .SocialNetworkFont.text
        tf.attributedPlaceholder = NSAttributedString(string: "Ваш комментарий",
                                                      attributes: [.foregroundColor: UIColor.SocialNetworkColor.placeholderText])
        tf.tintColor = .SocialNetworkColor.accent
        tf.textColor = .SocialNetworkColor.primaryText
        tf.textAlignment = .left
        tf.leftView = UIView(frame: CGRect(x: 0,
                                           y: 0,
                                           width: 10,
                                           height: tf.frame.height))
        tf.leftViewMode = .always
        
        return tf
    }()
    
    private lazy var sendCommentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.up.circle.fill"), for: .normal)
        button.tintColor = .SocialNetworkColor.accent
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.backgroundColor = .white
        button.sizeToFit()
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        sendCommentButton.layer.cornerRadius = sendCommentButton.frame.height / 2
        sendCommentButton.layer.masksToBounds = true

        commentField.layer.cornerRadius = commentField.frame.height / 2
        commentField.layer.masksToBounds = true
    }
}

private extension PostCommentPanelView {
    func setupView() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        add(subviews: [commentField,
                       sendCommentButton])
        
        commentField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-4)
            make.trailing.equalTo(sendCommentButton.snp.leading).offset(-8)
            make.height.equalTo(sendCommentButton)
        }
        
        sendCommentButton.snp.makeConstraints { make in
            make.size.equalTo(36)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(commentField)
        }
    }
    
    func setupContent() {
        backgroundColor = .SocialNetworkColor.mainBackground
        
        commentField.layer.cornerRadius = commentField.frame.height / 2
        commentField.layer.masksToBounds = true
    }
}

private extension PostCommentPanelView {
    @objc func sendCommentButtonWasTapped() {
        delegate?.sendCommentButtonWasTapped(withText: commentText)
    }
    
    func setupActions() {
        sendCommentButton.addTarget(self, action: #selector(sendCommentButtonWasTapped), for: .touchUpInside)
    }
}
