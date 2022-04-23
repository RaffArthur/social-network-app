//
//  DocumentsTableViewCell.swift
//  Social_Network
//
//  Created by Arthur Raff on 23.04.2022.
//

import UIKit

class DocumentsTableViewCell: UITableViewCell {
    private lazy var image: UIImageView = {
        let iv = UIImageView()
        
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DocumentsTableViewCell {
    func setupCell() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        contentView.addSubview(image)
        
        image.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.center.equalToSuperview()
        }
    }
    
    func setupContent() {
        backgroundColor = .white
    }
}
