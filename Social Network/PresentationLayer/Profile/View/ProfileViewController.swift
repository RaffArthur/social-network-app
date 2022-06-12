//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Артур Рафф on 02.10.2020.
//

import UIKit
import SnapKit

final class ProfileViewController: UIViewController {
    weak var reviewer: AuthentificationReviewer?
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
        
        loadFullUserData()
        
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
}

private extension ProfileViewController {
    func loadFullUserData() {
        photosAdapter.getPhotos { [weak self] result in
            let photos = result.photos.map {
                return Photo(url: $0.url, thumbnailURL: $0.thumbnailURL)
            }
            
            Storages.photos.append(contentsOf: photos)
            
            self?.tableView.reloadData()
            
        }
        
        postsAdapter.getPosts { [weak self] result in
            let posts = result.posts.map {
                return Post(title: $0.title, body: $0.body)
            }
            
            Storages.posts.append(contentsOf: posts)
            
            self?.tableView.reloadData()
        }        
    }
}

private extension ProfileViewController {
    @objc func logOutButtonTapped() {
        let credentials = UserCredentials(email: nil,
                                          password: nil,
                                          repeatPassword: nil,
                                          loggedIn: false)
        
        reviewer?.signOutWith(credentials: credentials) { [weak self] result in
            switch result {
            case .success:
                self?.delegate?.logoutButtonWasTapped()
            case .failure(let error):
                self?.show(error: error)
            }
        }
    }
    
    @objc func didTapPost(_ sender: UITapGestureRecognizer) {
        let touchPoint = sender.location(in: tableView)
        
        guard let indexPath = tableView.indexPathForRow(at: touchPoint) else { return }
        
        let post = Storages.posts[indexPath.item]
        
        CoreDataManager.shared.fetchFavouritePosts { favouritePosts in
            DispatchQueue.main.async { [weak self] in
                if favouritePosts.isEmpty {
                    self?.delegate?.postWasTapped(post: post)
                    self?.animateAddToFavouriteTap()
                }
                
                if favouritePosts.contains(where: { $0.title == post.title }) {
                    self?.showAlreadyInFavouritesAlert()
                } else {
                    self?.delegate?.postWasTapped(post: post)
                    self?.animateAddToFavouriteTap()
                }
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
    
    func showAlreadyInFavouritesAlert() {
        let alert = UIAlertController(title: nil,
                                      message: nil,
                                      preferredStyle: .alert)
        
        let attributedString = NSAttributedString(string: "Уже в избранном",
                                                  attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .bold),
                                                               NSAttributedString.Key.foregroundColor : UIColor.systemRed])
                
        alert.setValue(attributedString, forKey: "attributedMessage")
        
        present(alert, animated: true)
                
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    func animateAddToFavouriteTap() {
        let addedScale = CGFloat.random(in: 0.8...2.0)
        
        let rotationAngle = CGFloat.random(in: -12...36)
        
        let imageView = UIImageView(image: UIImage(systemName: "heart.fill"))
        
        imageView.tintColor = .systemRed
                                
        guard let tabBarView = tabBarController?.view else { return }
        
        imageView.center = CGPoint(x: tabBarView.center.x, y: tabBarView.center.y)

        tabBarView.addSubview(imageView)

        UIView.animate(withDuration: 0) {
            imageView.bounds.origin = CGPoint(x: rotationAngle, y: rotationAngle)
            imageView.transform = CGAffineTransform(scaleX: addedScale, y: addedScale)
        } completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0.1) {
                imageView.center.y -= 100
                imageView.transform = CGAffineTransform(rotationAngle: rotationAngle)
                imageView.tintColor = .clear
                
            } completion: {_ in
                imageView.removeFromSuperview()
            }
        }
    }
    
    func setupActions() {
        logoutButton.target = self
        logoutButton.action = #selector(logOutButtonTapped)
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
        
        if indexPath.section == 0 {
            delegate?.photoLibraryWasTapped()
        } else {
            let tap = UITapGestureRecognizer(target: self,action: #selector(didTapPost))
            tap.numberOfTapsRequired = 2
            tableView.addGestureRecognizer(tap)
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : Storages.posts.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let identifier = String(describing: ProfilePhotosPreviewTableViewCell.self)
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier ,
                                                     for: indexPath) as? ProfilePhotosPreviewTableViewCell
            
            if !Storages.photos.isEmpty {
                cell?.configure(photos: Storages.photos)
            }
            
            return cell ?? UITableViewCell()
        } else {
            let identifier = String(describing: ProfilePostTableViewCell.self)
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                     for: indexPath) as? ProfilePostTableViewCell
            let post = Storages.posts[indexPath.row]
            
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

private extension ProfileViewController {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupContent() {
        view.backgroundColor = .systemBackground
        
        navigationItem.leftBarButtonItem = logoutButton
    }
    
    func setupLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
