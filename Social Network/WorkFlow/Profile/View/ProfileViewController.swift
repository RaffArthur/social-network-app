//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Артур Рафф on 02.10.2020.
//

import UIKit
import SnapKit

final class ProfileViewController: UIViewController {
    weak var reviewer: LoginReviewer?
    weak var delegate: ProfileViewControllerDelegate?
    
    private lazy var postsAdapter = PostsAdapter()
    private lazy var photosAdapter = PhotosAdapter()
    
    private lazy var headerView = ProfileHeaderView()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(ProfilePostTableViewCell.self,
                           forCellReuseIdentifier: String(describing: ProfilePostTableViewCell.self))
        tableView.register(ProfilePhotosPreviewTableViewCell.self,
                           forCellReuseIdentifier: String(describing: ProfilePhotosPreviewTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
                
        return tableView
    }()
    
    private lazy var logoutButton: UIBarButtonItem = {
        let bbi = UIBarButtonItem()
        bbi.title = "Выход"
        bbi.style = .done
        
        return bbi
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postsAdapter.setupData()
        photosAdapter.setupData()
        
        postsAdapter.onDataReceive = { [weak self] in
            self?.tableView.reloadData()
        }
        
        photosAdapter.onDataReceive = { [weak self] in
            self?.tableView.reloadData()
        }
        
        setupScreen()
        setupActions()
        
        headerView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                        
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = false
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard indexPath.section == 0 else { return }
        
        delegate?.photoLibraryWasTapped()
    }
}

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return section == 0 ? 1 : postsAdapter.posts.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfilePhotosPreviewTableViewCell.self), for: indexPath) as? ProfilePhotosPreviewTableViewCell
                        
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfilePostTableViewCell.self), for: indexPath) as? ProfilePostTableViewCell
            let post = postsAdapter.posts[indexPath.item]
            
            cell?.configure(post: post)
            
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return UIView() }
        
        return headerView
    }
}

private extension ProfileViewController {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupContent() {
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = logoutButton
    }
    
    func setupLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}


private extension ProfileViewController {
    @objc func logOutButtonTapped() {
        guard let reviewer = reviewer else { return }
        
        reviewer.signOut { [weak self] result in
            switch result {
            case .success:
                self?.delegate?.logoutButtonWasTapped()
            case .failure(let error):
                self?.show(error: error)
            }
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
    
    func setupActions() {
        logoutButton.target = self
        logoutButton.action = #selector(logOutButtonTapped)
    }
}

extension ProfileViewController: ProfileHeaderViewDelegate {
    func setUserStatusButtonTapped() {
        let alertController = UIAlertController(title: "Обновите свой статус",
                                   message: "Введите здесь все, что вы думаете",
                                   preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Отменить",
                                   style: .cancel,
                                   handler: nil)
        
        let setStatus = UIAlertAction(title: "Обновить",
                                      style: .default) { action in
            self.headerView.updateUserStatus(message: alertController.textFields?[0].text ?? String())
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Введите свой статус"
        }
        
        alertController.addAction(cancel)
        alertController.addAction(setStatus)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func userPhotoTapped() {
        headerView.openFullUserPhoto()
        
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    
    func userPhotoCloseButtonTapped() {
        headerView.closeFullUserPhoto()
        
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = false
    }
}
