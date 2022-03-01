//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Артур Рафф on 02.10.2020.
//

import UIKit
import SnapKit

@available(iOS 13.0, *)
final class ProfileViewController: UIViewController {
    weak var reviewer: LoginReviewer?
    var didSendEventClosure: ((ProfileViewController.Event) -> Void)?
    
    private lazy var adapter = PostsAdapter()
    private lazy var headerView = ProfileHeaderView()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(ProfilePostTableViewCell.self, forCellReuseIdentifier: String(describing: ProfilePostTableViewCell.self))
        tableView.register(ProfilePhotosPreviewTableViewCell.self, forCellReuseIdentifier: String(describing: ProfilePhotosPreviewTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
                
        return tableView
    }()
    private lazy var logOutButton: UIBarButtonItem = {
        let bbi = UIBarButtonItem()
        bbi.title = "Выход"
        
        return bbi
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adapter.setupData()
        
        adapter.onDataReceive = {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                self.tableView.reloadData()
            }
        }
        
        setupScreen()
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let navigationController = navigationController else { return }
        guard let tabBarController = tabBarController else { return }
                
        tabBarController.tabBar.isHidden = false
        navigationController.navigationBar.isHidden = false
        navigationController.interactivePopGestureRecognizer?.isEnabled = false
        
        headerView.photoTapped = { [weak self] in
            guard let self = self else { return }

            self.tableView.isScrollEnabled = false
            self.tableView.isUserInteractionEnabled = false
            tabBarController.tabBar.isHidden = true
            navigationController.navigationBar.isHidden = true
            navigationController.navigationBar.isTranslucent = false
        }
        
        headerView.closePhotoButtonTapped = { [weak self] in
            guard let self = self else { return }

            self.tableView.isScrollEnabled = true
            self.tableView.isUserInteractionEnabled = true
            tabBarController.tabBar.isHidden = false
            navigationController.navigationBar.isHidden = false
            navigationController.navigationBar.isTranslucent = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.tableView.reloadData()
        }
    }
}

@available(iOS 13.0, *)
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard indexPath.section == 0 else { return }
        guard let event = didSendEventClosure else { return }
        
        event(.openPhotoLibrary)
    }
}

@available(iOS 13.0, *)
extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 1 }
        
        return adapter.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfilePhotosPreviewTableViewCell.self), for: indexPath) as! ProfilePhotosPreviewTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfilePostTableViewCell.self), for: indexPath) as! ProfilePostTableViewCell
            let post = adapter.posts[indexPath.row]
            
            cell.post = post
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        
        return headerView
    }
}

@available(iOS 13.0, *)
private extension ProfileViewController {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupContent() {
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = logOutButton
    }
    
    func setupLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

@available(iOS 13.0, *)
private extension ProfileViewController {
    func setupActions() {
        logOutButton.target = self
        logOutButton.action = #selector(logOutButtonTapped)
    }
}

@available(iOS 13.0, *)
private extension ProfileViewController {
    @objc func logOutButtonTapped() {
        guard let reviewer = reviewer else { return }

        do {
            let _ = try reviewer.signOut { [weak self] result in
                guard let self = self else { return }
                guard let event = self.didSendEventClosure else { return }
                
                switch result {
                case .success:
                    event(.signOut)
                case .failure(let error):
                    self.show(error: error)
                }
            }
        } catch {
            show(error: .unknownError)
        }
    }
    
    func show(error: UserAuthError) {
        let alertController = UIAlertController(title: error.title,
                                                 message: error.message,
                                                 preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК",
                                   style: .cancel,
                                   handler: nil)
        
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }
}

@available(iOS 13.0, *)
extension ProfileViewController {
    enum Event {
        case openPhotoLibrary
        case signOut
    }
}
