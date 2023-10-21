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
    private lazy var service = Services.userDataService()
        
    private lazy var profileUserHeaderView = ProfileUserHeaderView()
    private lazy var profilePostsHeaderView = ProfilePostsHeaderView()

    private lazy var profileView = ProfileView()
    
    private lazy var nickName = String()
    private lazy var userName = String()
    private lazy var userSurname = String()
    private lazy var userRegalia = String()
    private lazy var postLikes = Int()
    private lazy var postComments = Int()
    
    private lazy var logoutButton: UIBarButtonItem = {
        let bbi = UIBarButtonItem()
        bbi.title = .localized(key: .logOutButton)
        bbi.tintColor = .SocialNetworkColor.accent
        bbi.style = .done
        
        return bbi
    }()
    
    private lazy var nickNameButton: UIBarButtonItem = {
        let bbi = UIBarButtonItem()
        bbi.title = "@usernickname"
        bbi.tintColor = .SocialNetworkColor.accent
        
        return bbi
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = false
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        service.getUserData { [weak self] result in
            switch result {
            case .success(let data):
                guard let nickname = data.nickname,
                      let name = data.name,
                      let surname = data.surname,
                      let regalia = data.regalia
                else {
                    return
                }
                
                self?.nickName = nickname
                self?.userName = name
                self?.userSurname = surname
                self?.userRegalia = regalia
                
                self?.nickNameButton.title = nickname
                
                self?.profileUserHeaderView.setupUserInfo(name: "\(name) \(surname)",
                                                          regalia: regalia)
                
                self?.profileView.tableViewReloadData()

            case .failure(let error):
                self?.show(mainProfileError: error)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFullUserData()
        
        setupContent()
        setupActions()
        
        profileUserHeaderView.delegate = self
        profileView.tableView(delegate: self, dataSource: self)
    }
    
    override func loadView() {
        view = profileView
    }
}

private extension ProfileViewController {
    func loadFullUserData() {
        photosAdapter.getPhotos { [weak self] result in
            let photos = result.photos.map {
                return Photo(url: $0.url, thumbnailURL: $0.thumbnailURL)
            }
            
            Storages.photos.append(contentsOf: photos)
            
            self?.profileView.tableViewReloadData()
            
        }
        
        // Нужно поправить данные
        postsAdapter.getPosts { [weak self] result in
            let posts = result.posts.map {
                return Post(title: $0.title,
                            body: $0.body,
                            isPostLiked: true,
                            isPostAddedToFavourite: true,
                            likes: String(describing: self?.postLikes),
                            comments: String(describing: self?.postComments))
            }
            
            Storages.posts.append(contentsOf: posts)
            
            self?.profileView.tableViewReloadData()
        }
    }
}

private extension ProfileViewController {
    @objc func userNicknameTapped() {
        UIPasteboard.general.string = nickNameButton.title
        
        showNicknameCopiedToClipboardAlert()
    }
    
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
    
    func show(mainProfileError: UserMainProfileInfoError) {
        let alertController = UIAlertController(title: mainProfileError.title,
                                                 message: mainProfileError.message,
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
        
        let attributedString = NSAttributedString(string: .localized(key: .alreadyInFavouritesAlertTitle),
                                                  attributes: [NSAttributedString.Key.font : UIFont.SocialNetworkFont.caption1,
                                                               NSAttributedString.Key.foregroundColor : UIColor.SocialNetworkColor.destructive])
                
        alert.setValue(attributedString, forKey: "attributedMessage")
        
        present(alert, animated: true)
                
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    func showNicknameCopiedToClipboardAlert() {
        let alert = UIAlertController(title: nil,
                                      message: nil,
                                      preferredStyle: .actionSheet)
        
        let attributedString = NSAttributedString(string: "Ссылка скопирована",
                                                  attributes: [NSAttributedString.Key.font : UIFont.SocialNetworkFont.caption1,
                                                               NSAttributedString.Key.foregroundColor : UIColor.SocialNetworkColor.primaryText])
                
        alert.setValue(attributedString, forKey: "attributedMessage")
        
        present(alert, animated: true)
                
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    func setupActions() {
        logoutButton.target = self
        logoutButton.action = #selector(logOutButtonTapped)
        
        nickNameButton.target = self
        nickNameButton.action = #selector(userNicknameTapped)
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
        return section == 0 ? 1 : Storages.posts.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let identifier = String(describing: ProfilePhotosPreviewTableViewCell.self)
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier ,
                                                     for: indexPath) as? ProfilePhotosPreviewTableViewCell
            
            cell?.selectionStyle = .none
            
            if !Storages.photos.isEmpty {
                cell?.configure(photos: Storages.photos, withCount: Storages.photos.count)
            }
            
            return cell ?? UITableViewCell()
        } else {
            let identifier = String(describing: ProfilePostTableViewCell.self)
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                     for: indexPath) as? ProfilePostTableViewCell
            
            cell?.delegate = self
            
            cell?.selectionStyle = .none
                        
            let post = Storages.posts[indexPath.row]
            
            cell?.configure(post: post, userName: "\(userName) \(userSurname)", userRegalia: userRegalia)
            
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {        
        if section == 0 {
            return profileUserHeaderView
        } else {
            return profilePostsHeaderView
        }
    }
}

extension ProfileViewController: ProfileHeaderViewDelegate {
    func userMoreInfoButtonTapped() {
        delegate?.userMoreInfoButtonWasTapped()
    }
    
    func userEditInfoButtonTapped() {
        delegate?.userEditInfoButtonWasTapped()
    }
}

extension ProfileViewController: ProfilePostTableViewCellDelegate {
    func postLikesButtonWasTapped(sender: UIButton) {
        let indexPath = profileView.tableViewIndexPath(sender: sender)
        
        postLikes += 1
        
        profileView.tableViewReloadData()
    }
    
    func postCommentsButtonWasTapped(sender: UIButton) {
        let indexPath = profileView.tableViewIndexPath(sender: sender)
        
        postComments += 1
                
        profileView.tableViewReloadData()
    }
    
    func postAddToFavouritesButtonWasTapped(sender: UIButton) {
        let indexPath = profileView.tableViewIndexPath(sender: sender)
        
        print(indexPath)
        
        let post = Storages.posts[indexPath.item]
        
        CoreDataManager.shared.fetchFavouritePosts { favouritePosts in
            DispatchQueue.main.async { [weak self] in
                if favouritePosts.isEmpty {
                    self?.delegate?.postWasAddedToFavourite(post: post)
                } else {
                    if favouritePosts.contains(where: { $0.title == post.title }) {
                        self?.showAlreadyInFavouritesAlert()
                    } else {
                        self?.delegate?.postWasAddedToFavourite(post: post)
                    }
                }
            }
        }
    }
}

private extension ProfileViewController {
    func setupContent() {
        view.backgroundColor = .SocialNetworkColor.mainBackground
        navigationItem.rightBarButtonItem = logoutButton
        navigationItem.leftBarButtonItem = nickNameButton
    }
}
