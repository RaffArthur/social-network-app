//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Артур Рафф on 02.10.2020.
//

import UIKit
import SnapKit

@available(iOS 13.0, *)
class ProfileViewController: UIViewController {
    weak var coordinator: ProfileCoordinator?
    private lazy var adapter = PostsAdapter()
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(ProfilePostTableViewCell.self, forCellReuseIdentifier: String(describing: ProfilePostTableViewCell.self))
        tableView.register(ProfilePhotosPreviewTableViewCell.self, forCellReuseIdentifier: String(describing: ProfilePhotosPreviewTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
                
        return tableView
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let navigationController = navigationController else { return }
        guard let tabBarController = navigationController.tabBarController else { return }
        
        tabBarController.tabBar.isHidden = false
        navigationController.isNavigationBarHidden = true
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
        guard let coordinator = coordinator else { return }
        
        coordinator.openPhotoGallery()
    }
}

@available(iOS 13.0, *)
extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 1 }
        
        return adapter.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfilePhotosPreviewTableViewCell.self), for: indexPath) as! ProfilePhotosPreviewTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfilePostTableViewCell.self), for: indexPath) as! ProfilePostTableViewCell
            let post = adapter.dataSource[indexPath.row]
            
            cell.post = post
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        
        let headerView = ProfileHeaderView()
        
        return headerView
    }
}

@available(iOS 13.0, *)
extension ProfileViewController: ScreenSetupper {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupContent() {
        view.backgroundColor = .white
    }
    
    func setupLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
