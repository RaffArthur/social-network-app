//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Arthur Raff on 25.10.2020.
//

import UIKit
import SwiftyJSON

@available(iOS 13.0, *)
class PhotosCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties    
    private lazy var photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 8
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    
    // MARK: - Layout Funcs
    private func setupLayout() {
        contentView.addSubview(photoImageView)
        
        photoImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        setupLayout()
    }
    
    // MARK: - Get Photo from URL (Parsing)
    func getPhoto(from url: String) {
        DispatchQueue.main.async { [weak self] in
            self?.photoImageView.downloaded(from: url)
        }
    }
}

