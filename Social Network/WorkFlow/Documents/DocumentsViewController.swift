//
//  DocumentsViewController.swift
//  Social_Network
//
//  Created by Arthur Raff on 22.04.2022.
//

import UIKit

final class DocumentsViewController: UIViewController {
    private lazy var addPhotoButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "doc.badge.plus")
        
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.register(DocumentsTableViewCell.self,
                    forCellReuseIdentifier: String(describing: DocumentsTableViewCell.self))
        tv.delegate = self
        tv.dataSource = self
        
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
        
        setupActions()
    }
}

private extension DocumentsViewController {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupContent() {
        view.backgroundColor = .white
        
        title = "Документы"

        navigationItem.rightBarButtonItem = addPhotoButton
    }
}

private extension DocumentsViewController {
    func setupActions() {
        addPhotoButton.action = #selector(addFileToDocuments)
        addPhotoButton.target = self
    }
    
    @objc func addFileToDocuments() {
        let imagePickerController = UIImagePickerController()
        
        present(imagePickerController, animated: true)
    }
}

extension DocumentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension DocumentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: DocumentsTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier ,
                                                 for: indexPath) as? DocumentsTableViewCell
        
        return cell ?? UITableViewCell()
    }
}
