//
//  FeedViewController.swift
//  Navigation
//
//

import Foundation
import UIKit

final class FavouriteViewController: UIViewController {
    private var favouritePosts: [UserPost] = []
    private var filteredFavouritePosts: [UserPost] = []
    
    private lazy var userDataService = Services.userDataService()
    private lazy var userPostsService = Services.userPostsService()
    
    private lazy var favouriteView = FavouriteView()
    
    private lazy var userName = String()
    private lazy var userSurname = String()
    private lazy var userRegalia = String()
    
    private lazy var deleteAllButton: UIBarButtonItem = {
        let bbi = UIBarButtonItem()
        bbi.image = UIImage(systemName: "trash")
        bbi.style = .done
        
        return bbi
    }()
    
    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchBar.placeholder = .localized(key: .favouritesSearchPlaceholder)
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchResultsUpdater = self
        
        return sc
    }()
    
    private var serachBarIsEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !serachBarIsEmpty
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadFavouritePosts()
        loadUserData()
        
        if favouritePosts.isEmpty {
            deleteAllButton.isEnabled = false
            deleteAllButton.tintColor = .SocialNetworkColor.secondaryBackground
        } else {
            deleteAllButton.isEnabled = true
            deleteAllButton.tintColor = .SocialNetworkColor.accent
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupContent()
        setupActions()
        
        favouriteView.tableView(delegate: self, dataSource: self)
    }
    
    override func loadView() {
        view = favouriteView
    }
}

private extension FavouriteViewController {
    func setupContent() {
        navigationItem.rightBarButtonItem = deleteAllButton
        
        navigationItem.searchController = searchController
        
        definesPresentationContext = true
        
        view.backgroundColor = .SocialNetworkColor.mainBackground
    }
}

private extension FavouriteViewController {
    @objc func deleteAllButtonTapped() {
//        userFavouritePostsService.removeAllUserPostFromFavourite()
        
        loadFavouritePosts()
    }
    
    func setupActions() {
        deleteAllButton.target = self
        deleteAllButton.action = #selector(deleteAllButtonTapped)
    }
    
    func loadFavouritePosts() {
        userPostsService.getFavouritePosts { [weak self] result in
            switch result {
            case .success(let data):
                self?.favouritePosts = data
                self?.navigationItem.title = "\(String.localized(key: .favouritesCounterTitle)) \(data.count)"
                self?.favouriteView.tableViewReloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadUserData() {
        userDataService.getUserData { [weak self] result in
            switch result {
            case .success(let data):
                guard let name = data.name,
                      let surname = data.surname,
                      let regalia = data.regalia
                else {
                    return
                }
                
                self?.userName = name
                self?.userSurname = surname
                self?.userRegalia = regalia
                
                self?.favouriteView.tableViewReloadData()

            case .failure(let error):
                self?.show(mainProfileError: error)
            }
        }
    }
}

private extension FavouriteViewController {
//    func deleteFavouritePost(_ sender: UITapGestureRecognizer) {
//        let indexPath = favouriteView.getTableViewTouchPointIndexPath(sender: sender)
//        
//        CoreDataManager.shared.removePostFrom(favouritePosts: favouritePosts[indexPath.item])
//        
//        favouritePosts.remove(at: indexPath.row)
//        
//        favouriteView.tableViewDeleteRowsAt(indexPath: [indexPath], withAnimation: .automatic)
//    }
//    
//    func deleteFilteredFavouritePost(_ sender: UITapGestureRecognizer) {
//        let indexPath = favouriteView.getTableViewTouchPointIndexPath(sender: sender)
//        
//        favouritePosts.forEach { favPost in
//            if filteredFavouritePosts.contains(where: { $0.body == favPost.body }) {
//                CoreDataManager.shared.removePostFrom(favouritePosts: favPost)
//            }
//        }
//        
//        filteredFavouritePosts.remove(at: indexPath.row)
//        
//        favouriteView.tableViewDeleteRowsAt(indexPath: [indexPath], withAnimation: .automatic)
//    }
    
    func filterContentForSearchBy(text: String) {
        filteredFavouritePosts = favouritePosts.filter {
            guard let title = $0.body else { return false }
            
            return title.lowercased().contains(text.lowercased())
        }
        
        favouriteView.tableViewReloadData()
    }
}

extension FavouriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FavouriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredFavouritePosts.count
        }
        
        return favouritePosts.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: ProfilePostTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                 for: indexPath) as? ProfilePostTableViewCell
        
        var favouritePost: UserPost
        var isLiked = Bool()
        var isAddedToFavourite = Bool()
        
        if isFiltering {
            favouritePost = filteredFavouritePosts[indexPath.row]
            favouritePost.postFavourites?.forEach { isAddedToFavourite = $0.isAddedToFavourite! }
            favouritePost.postLikes?.forEach { isLiked = $0.isLiked! }
        } else {
            favouritePost = favouritePosts[indexPath.row]
            favouritePost.postFavourites?.forEach { isAddedToFavourite = $0.isAddedToFavourite! }
            favouritePost.postLikes?.forEach { isLiked = $0.isLiked! }
        }
        
        cell?.configureWith(indexPath: indexPath,
                            userPost: favouritePost,
                            userName: userName,
                            userRegalia: userRegalia,
                            isPostLiked: isLiked,
                            isPostAddedToFavourite: isAddedToFavourite)
        
        return cell ?? UITableViewCell()
    }
}

extension FavouriteViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if !isFiltering {
            loadFavouritePosts()
        }
        
        guard let text = searchController.searchBar.text else { return }
        
        filterContentForSearchBy(text: text)
    }
}

extension FavouriteViewController {
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
}
