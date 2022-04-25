//
//  DocumentsTableViewCell.swift
//  Social_Network
//
//  Created by Arthur Raff on 23.04.2022.
//

import UIKit

final class DocumentsTableViewCell: UITableViewCell {
    private lazy var documentPreview: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        
        return iv
    }()
    
    private lazy var documentTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        
        return label
    }()
    
    private lazy var documentCreationDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .systemGray

        return label
    }()
    
    private lazy var documentType: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .systemGray

        return label
    }()
    
    private lazy var documentSize: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .systemGray

        return label
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

extension DocumentsTableViewCell {
    func configure(file: File) {
        guard let fileUrl = file.url,
              let fullUrl = URL(string: fileUrl),
              let fileData = try? Data(contentsOf: fullUrl),
              let fileName = file.name,
              let fileCreationDate = file.creationDate,
              let fileSize = file.size,
              let fileType = file.type
        else {
            return
        }
        
        let imageSize = CGSize(width: 120, height: 120)
        let originalImage = UIImage(data: fileData)
        let imgRect = CGRect(origin: CGPoint(x:0.0, y:0.0), size: imageSize)
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 1)
        originalImage?.draw(in: imgRect)
        let copied = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        documentPreview.image = copied
        documentTitle.text = "Имя: \(fileName)"
        documentCreationDate.text = "Дата создания: \(fileCreationDate)"
        documentSize.text = "Размер: \(fileSize)"
        documentType.text = "Тип файла: \(fileType)"
    }
}

private extension DocumentsTableViewCell {
    func setupCell() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        contentView.add(subviews: [documentPreview,
                                   documentTitle,
                                   documentType,
                                   documentSize,
                                   documentCreationDate])
        
        documentPreview.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        documentTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(documentPreview.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        documentType.snp.makeConstraints { make in
            make.top.equalTo(documentTitle.snp.bottom).offset(8)
            make.leading.equalTo(documentPreview.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-8)
        }
                
        documentSize.snp.makeConstraints { make in
            make.top.equalTo(documentType.snp.bottom).offset(8)
            make.leading.equalTo(documentPreview.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        documentCreationDate.snp.makeConstraints { make in
            make.top.equalTo(documentSize.snp.bottom).offset(8)
            make.leading.equalTo(documentPreview.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-8)
        }
    }
    
    func setupContent() {
        backgroundColor = .white
    }
}
