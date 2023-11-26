//
//  PostCreatingView.swift
//  Social_Network
//
//  Created by Arthur Raff on 28.10.2023.
//

import Foundation
import UIKit

final class PostCreatingView: UIView {
    weak var delegate: PostCreatingViewDelegate?
    
    lazy var commentText: String = { return commentTextView.text }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        
        return sv
    }()
    
    private lazy var commentPlaceholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Что у вас нового?"
        label.font = .SocialNetworkFont.t2
        label.textColor = .SocialNetworkColor.secondaryText
        label.backgroundColor = .SocialNetworkColor.clearBackground
        label.sizeToFit()
        
        return label
    }()
    
    private lazy var commentTextView: UITextView = {
        let tv = UITextView()
        tv.font = .SocialNetworkFont.t2
        tv.textColor = .SocialNetworkColor.primaryText
        tv.backgroundColor = .SocialNetworkColor.clearBackground
        tv.keyboardType = .alphabet
        tv.translatesAutoresizingMaskIntoConstraints = true
        tv.textAlignment = .left
        tv.keyboardType = .alphabet
        tv.sizeToFit()
        
        return tv
    }()
    
    private lazy var addImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "photo"), for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.tintColor = .SocialNetworkColor.primaryBackground
        button.backgroundColor = .SocialNetworkColor.primaryForeground
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.contentEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
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
}

private extension PostCreatingView {
    func setupView() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.add(subviews: [commentTextView,
                                  addImageButton])
        
        commentTextView.addSubview(commentPlaceholderLabel)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview {
                $0.safeAreaLayoutGuide
            }.offset(16)
            
            make.bottom.trailing.equalToSuperview {
                $0.safeAreaLayoutGuide
            }.offset(-16)
        }
        
        commentTextView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(addImageButton.snp.top).offset(-16)
        }
        
        commentPlaceholderLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        addImageButton.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setupContent() {
        backgroundColor = .SocialNetworkColor.mainBackground
    }
}

private extension PostCreatingView {
    func setupActions() {
        addImageButton.addTarget(self, action: #selector(addimageButtonTapped), for: .touchUpInside)
    }
    
    @objc func addimageButtonTapped() {
        delegate?.addImageButtonWasTapped()
    }
}

extension PostCreatingView {
    func textView(delegate: UITextViewDelegate) {
        commentTextView.delegate = delegate
    }
    
    func textView(isEditing: Bool) {
        commentPlaceholderLabel.isHidden = isEditing
    }
}
