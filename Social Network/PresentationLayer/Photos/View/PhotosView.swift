//
//  PhotosView.swift
//  Social_Network
//
//  Created by Arthur Raff on 07.10.2023.
//

import Foundation
import UIKit

final class PhotosView: UIView {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(PhotosCollectionViewCell.self,
                    forCellWithReuseIdentifier: String(describing: PhotosCollectionViewCell.self))
        cv.backgroundColor = .SocialNetworkColor.mainBackground
        cv.showsVerticalScrollIndicator = true
        
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhotosView {
    func collectionView(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
    }
}

private extension PhotosView {
    func setupView() {
        setupLayout()
        setupContent()
    }
    
    func setupContent() {
        backgroundColor = .SocialNetworkColor.mainBackground
    }
    
    func setupLayout() {
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview {
                $0.safeAreaLayoutGuide
            }
        }
    }
}
