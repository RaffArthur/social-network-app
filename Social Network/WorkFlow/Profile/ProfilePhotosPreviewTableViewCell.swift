//
//  ProfilePhotosPreviewTableViewCell.swift.swift
//  Navigation
//
//  Created by Arthur Raff on 24.10.2020.
//

import UIKit

@available(iOS 13.0, *)
class ProfilePhotosPreviewTableViewCell: UITableViewCell {
    private lazy var photosLabel: UILabel = {
        let photosLabel = UILabel()
        photosLabel.text = "Photos"
        photosLabel.font = .systemFont(ofSize: 24, weight: .bold)
        photosLabel.textColor = .black
        
        return photosLabel
    }()
    private lazy var photosStack: UIStackView = {
        let sv = UIStackView()
        sv.distribution = .fillEqually
        sv.axis = .horizontal
        sv.spacing = 8
        sv.backgroundColor = .white

        return sv
    }()
    private lazy var photoOne: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 6
        iv.image = UIImage(systemName: "photo.fill")
        iv.tintColor = UIColor(named: "color_set")


        return iv
    }()
    private lazy var photoTwo: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 6
        iv.image = UIImage(systemName: "photo.fill")
        iv.tintColor = UIColor(named: "color_set")

        
        return iv
    }()
    private lazy var photoThree: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 6
        iv.image = UIImage(systemName: "photo.fill")
        iv.tintColor = UIColor(named: "color_set")
        
        return iv
    }()
    private lazy var photoFour: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 6
        iv.image = UIImage(systemName: "photo.fill")
        iv.tintColor = UIColor(named: "color_set")
        
        return iv
    }()
    private lazy var toPhotoStockButton: UIButton = {
        let toPhotoStockButton = UIButton()
        toPhotoStockButton.setImage(UIImage(systemName: "arrow.forward"), for: toPhotoStockButton.state)
        
        return toPhotoStockButton
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupScreen()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

@available(iOS 13.0, *)
extension ProfilePhotosPreviewTableViewCell {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupContent() {
        backgroundColor = .white
    }
    
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
}
