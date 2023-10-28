//
//  ProfilePhotosPreviewTableViewCell.swift.swift
//  Navigation
//
//  Created by Arthur Raff on 24.10.2020.
//

import UIKit

final class ProfilePhotosPreviewTableViewCell: UITableViewCell {
    private lazy var photosLabel: UILabel = {
        let photosLabel = UILabel()
        photosLabel.text = .localized(key: .photosTitle)
        photosLabel.font = .SocialNetworkFont.t2
        photosLabel.textColor = .SocialNetworkColor.primaryText
        
        return photosLabel
    }()
    
    private lazy var photosCountLabel: UILabel = {
        let photosLabel = UILabel()
        photosLabel.font = .SocialNetworkFont.t2
        photosLabel.textColor = .SocialNetworkColor.secondaryText
        
        return photosLabel
    }()
    
    private lazy var photosContainer: UIStackView = {
        let sv = UIStackView()
        sv.distribution = .fillEqually
        sv.axis = .horizontal
        sv.spacing = 4
        
        return sv
    }()
    
    private lazy var photoOne: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleToFill
        iv.layer.cornerRadius = 8

        return iv
    }()
    
    private lazy var photoTwo: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleToFill
        iv.layer.cornerRadius = 8
        
        return iv
    }()
    
    private lazy var photoThree: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleToFill
        iv.layer.cornerRadius = 8
        
        return iv
    }()
    
    private lazy var photoFour: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleToFill
        iv.layer.cornerRadius = 8
        
        return iv
    }()
    
    private lazy var photoGalleryChevron: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.forward")
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .SocialNetworkColor.accent
        
        return iv
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photosLabel.isHidden = false
        photosCountLabel.isHidden = false
        photosContainer.isHidden = false
        photoOne.image = .none
        photoTwo.image = .none
        photoThree.image = .none
        photoFour.image = .none
        photosLabel.textColor = .none
        photosLabel.textColor = .none
        photoGalleryChevron.image = .none
    }
}

extension ProfilePhotosPreviewTableViewCell {
    func configure(photos: [Photo], withCount: Int) {
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
        
        photosCountLabel.text = String(describing: withCount)
    }
}

private extension ProfilePhotosPreviewTableViewCell {
    func setupCell() {
        setupLayout()
        setupContent()
    }
    
    func setupContent() {
        backgroundColor = .SocialNetworkColor.mainBackground
    }
    
    func setupLayout() {
        contentView.add(subviews: [photosLabel,
                                   photosCountLabel,
                                   photosContainer,
                                   photoGalleryChevron])
        
        photosContainer.add(arrangedSubviews: [photoOne,
                                               photoTwo,
                                               photoThree,
                                               photoFour])
        
        photosLabel.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(16)
        }
        
        photosCountLabel.snp.makeConstraints { make in
            make.leading.equalTo(photosLabel.snp.trailing).offset(8)
            make.centerY.equalTo(photosLabel)
        }
        
        photoGalleryChevron.snp.makeConstraints { (make) in
            make.size.equalTo(24)
            make.centerY.equalTo(photosLabel)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        photosContainer.snp.makeConstraints { (make) in
            make.height.equalTo(photosContainer.snp.width).dividedBy(4)
            make.top.equalTo(photosLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}
