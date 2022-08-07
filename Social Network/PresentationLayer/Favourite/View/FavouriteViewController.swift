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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(ProfilePostTableViewCell.self,
                           forCellReuseIdentifier: String(describing: ProfilePostTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
                
        return tableView
    }()
    
    private lazy var deleteAllButton: UIBarButtonItem = {
        let bbi = UIBarButtonItem()
        bbi.image = UIImage(systemName: "trash")
        bbi.style = .done
        
        return bbi
    }()
    
    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchBar.placeholder = .setLocalizedStringWith(key: .favouritesSearchPlaceholder)
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
        setupActions()
    }
}

private extension FavouriteViewController {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupContent() {
        navigationItem.rightBarButtonItem = deleteAllButton
        
        navigationItem.searchController = searchController
        
        definesPresentationContext = true
        
        view.backgroundColor = .systemBackground
    }
    
    func setupLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

private extension FavouriteViewController {
    @objc func deleteAllButtonTapped() {
        let pathes = favouritePosts.enumerated().map { IndexPath(row: $0.offset, section: 0) }
        
        CoreDataManager.shared.deletAll()
        
        favouritePosts.removeAll()
        
        tableView.deleteRows(at: pathes, with: .automatic)
        
        navigationItem.title = "\(String.setLocalizedStringWith(key: .favouritesCounterTitle)) \(favouritePosts.count)"
    }
    
    @objc func didTapPost(_ sender: UITapGestureRecognizer) {
        if isFiltering {
            deleteFilteredFavouritePost(sender)
        } else {
            deleteFavouritePost(sender)
        }
                                
        navigationItem.title = "\(String.setLocalizedStringWith(key: .favouritesCounterTitle)) \(favouritePosts.count)"
    }
    
    func setupActions() {
        deleteAllButton.target = self
        deleteAllButton.action = #selector(deleteAllButtonTapped)
    }
}

private extension FavouriteViewController {
    func deleteFavouritePost(_ sender: UITapGestureRecognizer) {
        let touchPoint = sender.location(in: tableView)
        
        guard let indexPath = tableView.indexPathForRow(at: touchPoint) else { return }
        
        CoreDataManager.shared.removePostFrom(favouritePosts: favouritePosts[indexPath.row])

        favouritePosts.remove(at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func deleteFilteredFavouritePost(_ sender: UITapGestureRecognizer) {
        let touchPoint = sender.location(in: tableView)
        
        guard let indexPath = tableView.indexPathForRow(at: touchPoint) else { return }
        
        favouritePosts.forEach { favPost in
            if filteredFavouritePosts.contains(where: { $0.title == favPost.title }) {
                CoreDataManager.shared.removePostFrom(favouritePosts: favPost)
            }
        }
                
        filteredFavouritePosts.remove(at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func fetchFavouritePosts() {
        CoreDataManager.shared.fetchFavouritePosts { favouritePosts in
            DispatchQueue.main.async { [weak self] in
                self?.favouritePosts = favouritePosts
                
                self?.tableView.reloadData()
                                
                self?.navigationItem.title = "\(String.setLocalizedStringWith(key: .favouritesCounterTitle)) \(favouritePosts.count)"
            }
        }
    }
    
    func filterContentForSearchBy(text: String) {
        filteredFavouritePosts = favouritePosts.filter {
            guard let title = $0.title else { return false }
            
            return title.lowercased().contains(text.lowercased())
        }
        
        tableView.reloadData()
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
        
        cell?.configure(post: favouritePost)
        
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
