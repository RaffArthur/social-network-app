//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Arthur Raff on 24.10.2020.
//

import UIKit

@available(iOS 13.0, *)
class PhotosTableViewCell: UITableViewCell {
    // MARK: - Properties
    private let photosLabel: UILabel = {
        let photosLabel = UILabel()
        photosLabel.toAutoLayout()
        photosLabel.text = "Photos"
        photosLabel.font = .systemFont(ofSize: 24, weight: .bold)
        photosLabel.textColor = .black
        
        return photosLabel
    }()
    private lazy var photosStack: UIStackView = {
        let photosStack = UIStackView()
        photosStack.toAutoLayout()
        photosStack.distribution = .fillEqually
        photosStack.axis = .horizontal
        photosStack.spacing = 8

        return photosStack
    }()
    private let photoOne: UIImageView = {
        let image = UIImageView()
        image.toAutoLayout()
        image.image = UIImage(named: "photo_1")
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 6

        return image
    }()
    private let photoTwo: UIImageView = {
        let image = UIImageView()
        image.toAutoLayout()
        image.image = UIImage(named: "photo_2")
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 6
        
        return image
    }()
    private let photoThree: UIImageView = {
        let image = UIImageView()
        image.toAutoLayout()
        image.image = UIImage(named: "photo_3")
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 6
        
        return image
    }()
    private let photoFour: UIImageView = {
        let image = UIImageView()
        image.toAutoLayout()
        image.image = UIImage(named: "photo_4")
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 6
        
        return image
    }()
    private let toPhotoStockButton: UIButton = {
        let toPhotoStockButton = UIButton()
        toPhotoStockButton.toAutoLayout()
        toPhotoStockButton.setImage(UIImage(systemName: "arrow.forward"), for: toPhotoStockButton.state)
        
        return toPhotoStockButton
    }()
    
    // MARK: - Funcs
    func setupLayout() {
        contentView.addSubview(photosLabel)
        contentView.addSubview(photosStack)
        contentView.addSubview(toPhotoStockButton)
        
        photosStack.addArrangedSubview(photoOne)
        photosStack.addArrangedSubview(photoTwo)
        photosStack.addArrangedSubview(photoThree)
        photosStack.addArrangedSubview(photoFour)
        
        let constraints = [
            photosLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            photosLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            toPhotoStockButton.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor),
            toPhotoStockButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            photosStack.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 12),
            photosStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            photosStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            photosStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            photosStack.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 48)/4)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
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
