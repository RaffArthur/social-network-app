//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Arthur Raff on 12.10.2020.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    // MARK: - Properties
    private var post: UserPost? {
        didSet {
            guard let post = post else { return }
            
            configure(post)
        }
    }
    private let authorNameLabel: UILabel = {
        let authorNameLabel = UILabel()
        authorNameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        authorNameLabel.textColor = .black
        authorNameLabel.numberOfLines = 2
        
        return authorNameLabel
    }()
    private let postImageView: UIImageView = {
        let postImageView = UIImageView()
        postImageView.layer.masksToBounds = true
        postImageView.layer.cornerRadius = 18
        postImageView.contentMode = .scaleAspectFit
        postImageView.backgroundColor = .black
        
        return postImageView
    }()
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = .systemGray
        descriptionLabel.numberOfLines = 0
        
        return descriptionLabel
    }()
    private let likesLabel: UILabel = {
        let likesLabel = UILabel()
        likesLabel.font = .systemFont(ofSize: 14, weight: .bold)
        likesLabel.textColor = UIColor(named: "color_set")
        
        return likesLabel
    }()
    private let viewsLabel: UILabel = {
        let viewsLabel = UILabel()
        viewsLabel.font = .systemFont(ofSize: 14, weight: .bold)
        viewsLabel.textColor = UIColor(named: "color_set")
        
        return viewsLabel
    }()
    
    // MARK: - Layout funcs
    func setupLayout() {
        
        contentView.addSubview(authorNameLabel)
        contentView.addSubview(postImageView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(likesLabel)
        contentView.addSubview(viewsLabel)
        
        authorNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(16)
            make.leading.equalTo(contentView.snp.leading).offset(16)
        }
        
        postImageView.snp.makeConstraints { (make) in
            make.top.equalTo(authorNameLabel.snp.bottom).offset(12)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(postImageView.snp.bottom).offset(16)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
        }
        
        likesLabel.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.bottom.equalTo(contentView.snp.bottom).offset(-16)
        }
        
        viewsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
            make.bottom.equalTo(contentView.snp.bottom).offset(-16)
        }
    }
    
    func configure(_ post: UserPost) {
        authorNameLabel.text = post.author
        descriptionLabel.text = post.description
        postImageView.image = UIImage(named: post.image)
        likesLabel.text = String("Likes: \(post.likes)")
        viewsLabel.text = String("Views: \(post.views)")
    }
    
    // MARK: - Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)        
    }
}
