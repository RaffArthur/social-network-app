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
        cv.backgroundColor = .white
        
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupScreen()
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
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupContent() {
        backgroundColor = .systemBackground
    }
    
    func setupLayout() {
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview {
                $0.safeAreaLayoutGuide.snp.top
            }
            make.bottom.equalToSuperview {
                $0.safeAreaLayoutGuide.snp.bottom
            }
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
    }
}