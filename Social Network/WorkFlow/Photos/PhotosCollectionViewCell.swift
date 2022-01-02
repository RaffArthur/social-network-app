//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Arthur Raff on 25.10.2020.
//

import UIKit

@available(iOS 13.0, *)
class PhotosCollectionViewCell: UICollectionViewCell {
    var photo: Photo? {
        didSet {
            guard let photo = photo else { return }
            
            configure(photo)
        }
    }
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
    
    private func configure(_ photo: Photo) {
        guard let photo = photo.url else { return }
        
        self.photoInPhotos.downloaded(from: photo)
    }

}

@available(iOS 13.0, *)
extension PhotosCollectionViewCell {
    func setupScreen() {
        setupLayout()
    }
    
    func setupLayout() {
        contentView.addSubview(photoInPhotos)
        
        photoInPhotos.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
