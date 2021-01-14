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
    
    // MARK: - Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: String(describing: PhotosTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
                
        return tableView
    }()
    
    // MARK: - View Funcs
    private func setupLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view)
            make.trailing.equalTo(view)
            make.leading.equalTo(view)
            make.bottom.equalTo(view)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Posts"
        view.backgroundColor = .white
        navigationController?.hidesBarsOnSwipe = true

        setupLayout()
    }
}

@available(iOS 13.0, *)
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard indexPath.section == 0 else { return print("ERROR!!") }
        
        navigationController?.pushViewController(PhotosViewController(), animated: true)
    }
}

@available(iOS 13.0, *)
extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 1 }
        
        return UsersPostsStorage.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PhotosTableViewCell.self), for: indexPath) as! PhotosTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
            let post = UsersPostsStorage.posts[indexPath.row]
            
            cell.configure(post)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        
        let headerView = ProfileHeaderView()
        
        return headerView
    }
}


