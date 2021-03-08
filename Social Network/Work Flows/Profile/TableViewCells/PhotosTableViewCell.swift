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
        photosLabel.text = "Photos"
        photosLabel.font = .systemFont(ofSize: 24, weight: .bold)
        photosLabel.textColor = .black
        
        return photosLabel
    }()
    private lazy var photosStack: UIStackView = {
        let photosStack = UIStackView()
        photosStack.distribution = .fillEqually
        photosStack.axis = .horizontal
        photosStack.spacing = 8

        return photosStack
    }()
    private let photoOne: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "photo_1")
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 6

        return image
    }()
    private let photoTwo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "photo_2")
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 6
        
        return image
    }()
    private let photoThree: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "photo_3")
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 6
        
        return image
    }()
    private let photoFour: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "photo_4")
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 6
        
        return image
    }()
    private let toPhotoStockButton: UIButton = {
        let toPhotoStockButton = UIButton()
        toPhotoStockButton.setImage(UIImage(systemName: "arrow.forward"), for: toPhotoStockButton.state)
        
        return toPhotoStockButton
    }()
    
    // MARK: - Layout funcs
    func setupLayout() {
        contentView.addSubview(photosLabel)
        contentView.addSubview(photosStack)
        contentView.addSubview(toPhotoStockButton)
        
        photosStack.addArrangedSubview(photoOne)
        photosStack.addArrangedSubview(photoTwo)
        photosStack.addArrangedSubview(photoThree)
        photosStack.addArrangedSubview(photoFour)
        
        photosLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(12)
            make.leading.equalTo(contentView.snp.leading).offset(12)
        }
        
        toPhotoStockButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(photosLabel.snp.centerY)
            make.trailing.equalTo(contentView.snp.trailing).offset(-12)
        }
        
        photosStack.snp.makeConstraints { (make) in
            make.height.equalTo((UIScreen.main.bounds.width-48)/4)
            make.top.equalTo(photosLabel.snp.bottom).offset(12)
            make.leading.equalTo(contentView.snp.leading).offset(12)
            make.trailing.equalTo(contentView.snp.trailing).offset(-12)
            make.bottom.equalTo(contentView.snp.bottom).offset(-12)
        }
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
