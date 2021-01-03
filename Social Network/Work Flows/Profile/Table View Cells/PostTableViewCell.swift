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
        authorNameLabel.toAutoLayout()
        authorNameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        authorNameLabel.textColor = .black
        authorNameLabel.numberOfLines = 2
        
        return authorNameLabel
    }()
    private let postImageView: UIImageView = {
        let postImageView = UIImageView()
        postImageView.toAutoLayout()
        postImageView.layer.masksToBounds = true
        postImageView.layer.cornerRadius = 18
        postImageView.contentMode = .scaleAspectFit
        postImageView.backgroundColor = .black
        
        return postImageView
    }()
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.toAutoLayout()
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = .systemGray
        descriptionLabel.numberOfLines = 0
        
        return descriptionLabel
    }()
    private let likesLabel: UILabel = {
        let likesLabel = UILabel()
        likesLabel.toAutoLayout()
        likesLabel.font = .systemFont(ofSize: 14, weight: .bold)
        likesLabel.textColor = UIColor(named: "color_set")
        
        return likesLabel
    }()
    private let viewsLabel: UILabel = {
        let viewsLabel = UILabel()
        viewsLabel.toAutoLayout()
        viewsLabel.font = .systemFont(ofSize: 14, weight: .bold)
        viewsLabel.textColor = UIColor(named: "color_set")
        
        return viewsLabel
    }()
    
    // MARK: - Custom funcs
    func setupLayout() {
        
        contentView.addSubview(authorNameLabel)
        contentView.addSubview(postImageView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(likesLabel)
        contentView.addSubview(viewsLabel)

        let constraints = [
            authorNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            authorNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            postImageView.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: 12),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ]
        
        NSLayoutConstraint.activate(constraints)
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
