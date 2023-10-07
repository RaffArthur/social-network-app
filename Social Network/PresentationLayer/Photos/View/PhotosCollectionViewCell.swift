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
        super.init(coder: coder)
    }
    
    func configure(photo: Photo) {
        guard let photo = photo.url else { return }
        
        self.photoInPhotos.downloaded(from: photo)
    }

}

private extension PhotosCollectionViewCell {
    func setupScreen() {
        setupLayout()
    }
    
    func setupLayout() {
        contentView.addSubview(photoInPhotos)
        
        photoInPhotos.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
