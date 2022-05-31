//
//  ProfilePhotosPreviewTableViewCell.swift.swift
//  Navigation
//
//  Created by Arthur Raff on 24.10.2020.
//

import UIKit

class ProfilePhotosPreviewTableViewCell: UITableViewCell {
    private lazy var photosLabel: UILabel = {
        let photosLabel = UILabel()
        photosLabel.text = "Фотографии"
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
        iv.tintColor = UIColor(named: "color_set")

        return iv
    }()
    
    private lazy var photoTwo: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 6
        iv.tintColor = UIColor(named: "color_set")
        
        return iv
    }()
    
    private lazy var photoThree: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 6
        iv.tintColor = UIColor(named: "color_set")
        
        return iv
    }()
    
    private lazy var photoFour: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 6
        iv.tintColor = UIColor(named: "color_set")
        
        return iv
    }()
    
    private lazy var photoGalleryButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.forward"), for: .normal)
        
        return button
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupScreen()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(photos: [Photo]) {
        guard let firstPhotoUrl = photos[0].url,
              let secondPhotoUrl = photos[1].url,
              let thirdPhotoUrl = photos[2].url,
              let fourthPhotoUrl = photos[3].url
        else {
            return
        }
        
        photoOne.downloaded(from: firstPhotoUrl)
        photoTwo.downloaded(from: secondPhotoUrl)
        photoThree.downloaded(from: thirdPhotoUrl)
        photoFour.downloaded(from: fourthPhotoUrl)
    }
}

private extension ProfilePhotosPreviewTableViewCell {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupContent() {
        backgroundColor = .white
    }
    
    func setupLayout() {
        contentView.add(subviews: [photosLabel,
                                   photosStack,
                                   photoGalleryButton])
        
        photosStack.add(arrangedSubviews: [photoOne,
                                           photoTwo,
                                           photoThree,
                                           photoFour])
        
        photosLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(12)
            make.leading.equalToSuperview().offset(12)
        }
        
        photoGalleryButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(photosLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        photosStack.snp.makeConstraints { (make) in
            make.height.equalTo((UIScreen.main.bounds.width-48)/4)
            make.top.equalTo(photosLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
}
