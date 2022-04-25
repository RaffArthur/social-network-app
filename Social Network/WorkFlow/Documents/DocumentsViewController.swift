//
//  DocumentsViewController.swift
//  Social_Network
//
//  Created by Arthur Raff on 22.04.2022.
//

import UIKit

final class DocumentsViewController: UIViewController {
    private var files: [File] = []
    
    private let fileManager = SocialNetworkFileManager()
    
    private lazy var imagePickerController: UIImagePickerController = {
        let ipc = UIImagePickerController()
        ipc.delegate = self
        
        return ipc
    }()

    private lazy var addFileButton: UIBarButtonItem = {
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
        
        getFiles()
        
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
        tableView.backgroundColor = .white
        
        title = "Файлы"

        navigationItem.rightBarButtonItem = addFileButton
    }
}

private extension DocumentsViewController {
    func getFiles() {
        fileManager.getFilesFrom(directory: .documentDirectory) { files in
            let filesData = files?.compactMap {
                File(url: $0.absoluteString,
                     name: $0.lastPathComponent,
                     size: getFileAttributeBy(name: $0.lastPathComponent).size,
                     type: getFileAttributeBy(name: $0.lastPathComponent).type,
                     creationDate: getFileAttributeBy(name: $0.lastPathComponent).creationDate)
            }
            
            guard let data = filesData else { return }
            
            self.files = data
            
            tableView.reloadData()
        }
    }
    
    func getFileAttributeBy(name: String) -> (size: String,
                                              creationDate: String,
                                              type: String) {
        var convertedAttributes = (size: String(),
                                   creationDate: String(),
                                   type: String())
        
        fileManager.getFileAttributesFrom(directory: .documentDirectory,
                                          atName: name) { attributes in
            
            guard let creationDate = attributes?[.creationDate] as? Date,
                  let size = attributes?[.size] as? Double,
                  let type = attributes?[.type] as? String
            else {
                return
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeZone = TimeZone(identifier: "RU")
            dateFormatter.locale = Locale(identifier: "RU")
            
            convertedAttributes.creationDate = dateFormatter.string(from: creationDate)
            convertedAttributes.size = "\( round(size / 1024)) Кб"
            convertedAttributes.type = "\(type)"
        }
        
        return convertedAttributes
    }
}

private extension DocumentsViewController {
    func setupActions() {
        addFileButton.action = #selector(addFileToDocuments)
        addFileButton.target = self
    }
    
    @objc func addFileToDocuments() {
        imagePickerController.modalPresentationStyle = .automatic
        
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
        return files.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: DocumentsTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier ,
                                                 for: indexPath) as? DocumentsTableViewCell
        
        cell?.configure(file: files[indexPath.row])
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let trashAction = UIContextualAction(style: .destructive,
                                             title: "Удалить") { action, view, success in
            
            guard let name = self.files[indexPath.row].name else { return }
            
            self.fileManager.removeFileAt(directory: .documentDirectory,
                                          withName: name)
            
            self.files.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            success(true)
        }
        
        return UISwipeActionsConfiguration(actions: [trashAction])
    }
}

extension DocumentsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = (info[.originalImage] as? UIImage)?.jpegData(compressionQuality: 0.2),
              let name = (info[.imageURL] as? URL)?.lastPathComponent
        else {
            return
        }
        
        fileManager.create(file: image,
                           withName: name,
                           atDirectory: .documentDirectory)
        
        picker.dismiss(animated: true)
        
        getFiles()
    }
}
