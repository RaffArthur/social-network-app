//
//  ProfilePostTableViewCell.swift
//  Navigation
//
//  Created by Arthur Raff on 12.10.2020.
//

import UIKit

@available(iOS 13.0, *)
class ProfilePostTableViewCell: UITableViewCell {
    var post: Post? {
        didSet {
            guard let post = post else { return }
            
            configure(post)
        }
    }
    
    private lazy var postTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        
        return label
    }()
    private lazy var postPhoto: UIImageView = {
        let iv = UIImageView()
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 18
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "photo.fill")
        iv.backgroundColor = UIColor(named: "color_set")
        iv.tintColor = .white
        
        return iv
    }()
    private lazy var postDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 0
        
        return label
    }()
    private lazy var postLikes: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "color_set")
        
        return label
    }()
    private lazy var postViews: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "color_set")
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                        
        setupScreen()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configure(_ post: Post) {
        guard let postTitle = post.title else { return }
        guard let postDescription = post.body else { return }
        guard let postLikes = post.userID else { return }
        guard let postViews = post.id else { return }

        self.postTitle.text = postTitle.firstUppercased
        self.postDescription.text = postDescription
        self.postLikes.text = "Likes: \(postLikes)"
        self.postViews.text = "Vews: \(postViews)"
    }
}

@available(iOS 13.0, *)
extension ProfilePostTableViewCell {
    func setupScreen() {
        setupLayout()
    }
    
    func setupLayout() {
        
        contentView.addSubview(postTitle)
        contentView.addSubview(postPhoto)
        contentView.addSubview(postDescription)
        contentView.addSubview(postLikes)
        contentView.addSubview(postViews)
        
        postTitle.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(16)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
        }
        
        postPhoto.snp.makeConstraints { (make) in
            make.height.equalTo(100)
            make.width.equalTo(postPhoto.snp.height)
            make.top.equalTo(postTitle.snp.bottom).offset(12)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
        }
        
        postDescription.snp.makeConstraints { (make) in
            make.top.equalTo(postPhoto.snp.bottom).offset(16)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
        }
        
        postLikes.snp.makeConstraints { (make) in
            make.top.equalTo(postDescription.snp.bottom).offset(16)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.bottom.equalTo(contentView.snp.bottom).offset(-16)
        }
        
        postViews.snp.makeConstraints { (make) in
            make.top.equalTo(postDescription.snp.bottom).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
            make.bottom.equalTo(contentView.snp.bottom).offset(-16)
        }
    }
}
