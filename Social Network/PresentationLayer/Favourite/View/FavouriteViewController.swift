//
//  FeedViewController.swift
//  Navigation
//
//

import Foundation
import UIKit

final class FavouriteViewController: UIViewController {
    private var favouritePosts: [FavouritePost] = []
    private var filteredFavouritePosts: [FavouritePost] = []
    
    private lazy var service = Services.userDataService()
    
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
        
        fetchFavouritePosts()
        
        service.getUserData { [weak self] result in
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
        
        view.backgroundColor = .systemBackground
    }
}

private extension FavouriteViewController {
    @objc func deleteAllButtonTapped() {
        let pathes = favouritePosts.enumerated().map { IndexPath(row: $0.offset, section: 0) }
        
//        CoreDataManager.shared.deletAll()
        
        favouritePosts.removeAll()
        
        favouriteView.tableViewDeleteRowsAt(indexPath: pathes, withAnimation: .automatic)
        
        navigationItem.title = "\(String.localized(key: .favouritesCounterTitle)) \(favouritePosts.count)"
    }
    
    @objc func didTapPost(_ sender: UITapGestureRecognizer) {
        if isFiltering {
            deleteFilteredFavouritePost(sender)
        } else {
            deleteFavouritePost(sender)
        }
                                
        navigationItem.title = "\(String.localized(key: .favouritesCounterTitle)) \(favouritePosts.count)"
    }
    
    func setupActions() {
        deleteAllButton.target = self
        deleteAllButton.action = #selector(deleteAllButtonTapped)
    }
}

private extension FavouriteViewController {
    func deleteFavouritePost(_ sender: UITapGestureRecognizer) {
        let indexPath = favouriteView.getTableViewTouchPointIndexPath(sender: sender)
        
//        CoreDataManager.shared.removePostFrom(favouritePosts: favouritePosts[indexPath.item])
        
        favouritePosts.remove(at: indexPath.row)
        
        favouriteView.tableViewDeleteRowsAt(indexPath: [indexPath], withAnimation: .automatic)
    }
    
    func deleteFilteredFavouritePost(_ sender: UITapGestureRecognizer) {
        let indexPath = favouriteView.getTableViewTouchPointIndexPath(sender: sender)
        
        favouritePosts.forEach { favPost in
            if filteredFavouritePosts.contains(where: { $0.title == favPost.title }) {
//                CoreDataManager.shared.removePostFrom(favouritePosts: favPost)
            }
        }
        
        filteredFavouritePosts.remove(at: indexPath.row)
        
        favouriteView.tableViewDeleteRowsAt(indexPath: [indexPath], withAnimation: .automatic)
    }
    
    func fetchFavouritePosts() {
//        CoreDataManager.shared.fetchFavouritePosts { favouritePosts in
//            DispatchQueue.main.async { [weak self] in
//                self?.favouritePosts = favouritePosts
//                
//                self?.favouriteView.tableViewReloadData()
//                                
//                self?.navigationItem.title = "\(String.localized(key: .favouritesCounterTitle)) \(favouritePosts.count)"
//            }
//        }
    }
    
    func filterContentForSearchBy(text: String) {
        filteredFavouritePosts = favouritePosts.filter {
            guard let title = $0.title else { return false }
            
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
        
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(didTapPost))
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        tableView.addGestureRecognizer(doubleTapGestureRecognizer)
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
        
        var favouritePost: FavouritePost
        
        if isFiltering {
            favouritePost = filteredFavouritePosts[indexPath.row]
        } else {
            favouritePost = favouritePosts[indexPath.row]
        }
        
//        cell?.configure(post: favouritePost, userName: "\(userName) \(userSurname)", userRegalia: userRegalia)

        return cell ?? UITableViewCell()
    }
}

extension FavouriteViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if !isFiltering {
            fetchFavouritePosts()
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
