//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Arthur Raff on 25.10.2020.
//

import UIKit

final class PhotosCollectionViewCell: UICollectionViewCell {
    private lazy var photoInPhotos: UIImageView = {
        let iv = UIImageView()
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 8
        iv.contentMode = .scaleAspectFill
        iv.isUserInteractionEnabled = true
        
        return iv
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupScreen()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        photoInPhotos.image = .none
    }
}

extension PhotosCollectionViewCell {
    func configure(photo: Photo) {
        guard let photo = photo.url else { return }
        
        photoInPhotos.downloaded(from: photo)
    }
}

private extension PhotosCollectionViewCell {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupContent() {
        backgroundColor = .SocialNetworkColor.mainBackground
    }
    
    func setupLayout() {
        contentView.addSubview(photoInPhotos)
        
        photoInPhotos.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.bottom.trailing.equalToSuperview().priority(999)
        }
    }
}