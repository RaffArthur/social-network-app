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
        let tv = UITableView(frame: .zero, style: .plain)
        tv.register(DocumentsTableViewCell.self,
                    forCellReuseIdentifier: String(describing: DocumentsTableViewCell.self))
        tv.delegate = self
        tv.dataSource = self
        
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFullFilesData()
        
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
            make.edges.equalTo(view.safeAreaLayoutGuide)
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
    func getFullFilesData() {
        fileManager.getFilesWithAttributes(directory: .documentDirectory) { fullFilesData in
            let convertedFullFilesData = fullFilesData.compactMap {
                File(url:  $0.file.absoluteString,
                     name: $0.file.lastPathComponent,
                     size: convert(attribute: .size, in: $0.attributes),
                     type: $0.file.lastPathComponent.components(separatedBy: ".").last,
                     creationDate: convert(attribute: .creationDate, in: $0.attributes))
            }
            
            files = convertedFullFilesData
            
            tableView.reloadData()
        }
    }
        
    func convert(attribute: FileAttributeKey, in attributes: [FileAttributeKey: Any]) -> String {
        for _ in attributes {
            if attribute == .size {
                guard let size = attributes[.size],
                      let sizeDouble = size as? Int64
                else {
                    return String()
                }

                let formattedSize = ByteCountFormatter.string(fromByteCount: sizeDouble, countStyle: .file)

                return "\(formattedSize)"
            }
            
            if attribute == .creationDate {
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .long
                dateFormatter.timeZone = TimeZone(identifier: "RU")
                dateFormatter.locale = Locale(identifier: "RU")
                
                guard let creationDate = attributes[.creationDate],
                      let formattedCreationDate = dateFormatter.string(for: creationDate)
                else {
                    return String()
                }
                
                return formattedCreationDate
            }
        }
        
        return "отсутствует"
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
        
        getFullFilesData()
    }
}
