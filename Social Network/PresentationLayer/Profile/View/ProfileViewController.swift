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
    
    private lazy var photosAdapter = PhotosAdapter()
    private lazy var userDataService = Services.userDataService()
    private lazy var userPostService = Services.userPostsService()
    private lazy var userFavouritePostsService = Services.userFavouritePostsService()

    private lazy var profileUserHeaderView = ProfileUserHeaderView()
    private lazy var profilePostsHeaderView = ProfilePostsHeaderView()
    private lazy var profileView = ProfileView()
    
    private lazy var isPostLiked: Bool = false
    private lazy var isPostAddedToFavourite: Bool = false
        
    private lazy var nickName = String()
    private lazy var userName = String()
    private lazy var userSurname = String()
    private lazy var userRegalia = String()
    private lazy var userID = String()
    private lazy var postID = String()
    
    private lazy var userPosts: [UserPost] = []
    private lazy var favouriteUserPosts: [UserPost] = []
    
    private lazy var menuButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "line.horizontal.3"), for: .normal)
        button.tintColor = .SocialNetworkColor.accent
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        return button
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
        
        loadUserData()
        loadUserPosts()
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
    }
    
    func loadUserPosts() {
        userPostService.getUserPosts { [weak self] result in
            switch result {
            case .success(let data):
                self?.userPosts = data
                self?.profileView.tableViewReloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadUserData() {
        userDataService.getUserData { [weak self] result in
            switch result {
            case .success(let data):
                guard let uid = data.userID,
                      let nickname = data.nickname,
                      let name = data.name,
                      let surname = data.surname,
                      let regalia = data.regalia
                else {
                    return
                }
                
                self?.userID = uid
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
}

private extension ProfileViewController {
    @objc func userNicknameTapped() {
        UIPasteboard.general.string = nickNameButton.title
        
        showNicknameCopiedToClipboardAlert()
    }
    
    @objc func menuButtonTapped() {
        delegate?.menuButtonWasTapped()
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
                
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    func setupActions() {
        menuButton.addTarget(self,
                             action: #selector(menuButtonTapped),
                             for: .touchUpInside)
        
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
        
        if indexPath.section == 0 {
            delegate?.photoLibraryWasTapped()
        }
        
        if indexPath.section == 1 {
            let currentPost = userPosts[indexPath.item]

            guard let currentPostID = currentPost.id
            else {
                return
            }
            
            delegate?.userPostWasTapped(userID: userID,
                                        postID: currentPostID,
                                        post: currentPost,
                                        userName: userName,
                                        userRegalia: userRegalia,
                                        indexPath: indexPath,
                                        isPostLiked: isPostLiked,
                                        isPostAddedToFavourite: isPostAddedToFavourite)
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return section == 0 ? 1 : userPosts.count
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
            
            let currentPost = userPosts[indexPath.item]

            guard let currentPostID = currentPost.id
            else {
                return UITableViewCell()
            }
            
            postID = currentPostID
            
            cell?.configureWith(indexPath: indexPath,
                                userPost: currentPost,
                                userName: "\(userName) \(userSurname)",
                                userRegalia: userRegalia,
                                isPostLiked: isPostLiked,
                                isPostAddedToFavourite: isPostAddedToFavourite)
            
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
    
    func userPublishPostButtonWasTapped() {
        delegate?.userPublishPostButtonWasTapped()
    }
}

extension ProfileViewController: ProfilePostTableViewCellDelegate {
    func postLikesButtonWasTappedAt(indexPath: IndexPath) {
        guard let postID = userPosts[indexPath.row].id,
              let postLikeIDs = userPosts[indexPath.row].postLikes?.compactMap({ $0.id }),
              let postLikedUserIDs = userPosts[indexPath.row].postLikes?.compactMap({ $0.likedUserID })
        else {
            return
        }
        
        if postLikedUserIDs.contains(userID) {
            postLikeIDs.forEach { userPostService.removePostLike(userID: userID, postID: postID, likeID: $0) }
        } else {
            userPostService.savePostLike(userID: userID, postID: postID) { [weak self] result in
                switch result {
                case .success(_):
                    self?.loadUserData()
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        loadUserPosts()
    }
    
    func postCommentsButtonWasTappedAt(indexPath: IndexPath) {
        guard let currentPostID = userPosts[indexPath.row].id
        else {
            return
        }

        delegate?.userPostWasTapped(userID: userID,
                                    postID: currentPostID,
                                    post: userPosts[indexPath.row],
                                    userName: userName,
                                    userRegalia: userRegalia,
                                    indexPath: indexPath,
                                    isPostLiked: isPostLiked,
                                    isPostAddedToFavourite: isPostAddedToFavourite)
    }
    
    func postAddToFavouritesButtonWasTappedAt(indexPath: IndexPath) {
        guard let postID = userPosts[indexPath.row].id,
              let body = userPosts[indexPath.row].body
        else {
            return
        }
        
        userFavouritePostsService.addUserPostToFavourite(userPost: UserPost(id: postID,
                                                                            body: body,
                                                                            image: nil,
                                                                            postLikes: nil,
                                                                            postComments: nil)) { [weak self] result in
            switch result {
            case .success(let data):
                guard let userPost = self?.userPosts[indexPath.row] else { return }
                
                print(data)
                self?.favouriteUserPosts.insert(userPost, at: 0)
                self?.profileView.tableViewReloadData()
            case .failure(let error):
                print(error)
            }
        }
        
//        favouriteUserPosts.forEach {
//            guard let id = $0.id else { return }
//            
//            if id.contains(postID) {
//                userFavouritePostsService.removeUserPostFromFavourite(favouritePostID: "")
//            } else {
//                userFavouritePostsService.addUserPostToFavourite(userPost: userPosts[indexPath.row]) { [weak self] result in
//                    switch result {
//                    case .success(_):
//                        guard let userPost = self?.userPosts[indexPath.row] else { return }
//                        
//                        self?.favouriteUserPosts.insert(userPost, at: 0)
//                        self?.profileView.tableViewReloadData()
//                    case .failure(let error):
//                        print(error)
//                    }
//                }
//            }
//        }
    }
}

private extension ProfileViewController {
    func setupContent() {
        view.backgroundColor = .SocialNetworkColor.mainBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuButton)
        navigationItem.leftBarButtonItem = nickNameButton
        
        menuButton.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
    }
}
