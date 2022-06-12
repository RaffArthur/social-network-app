//
//  FeedViewController.swift
//  Navigation
//
//

import UIKit

final class FavouriteViewController: UIViewController {
    private var favouritePosts: [FavouritePost] = []
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        CoreDataManager.shared.fetchFavouritePosts { favouritePosts in
            DispatchQueue.main.async { [weak self] in
                self?.favouritePosts = favouritePosts
                
                self?.tableView.reloadData()
                                
                self?.navigationItem.title = "В избранном \(favouritePosts.count)"
            }
        }
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
        
        navigationItem.title = "В избранном \(favouritePosts.count)"
    }
    
    @objc func didPostTapped(_ sender: UITapGestureRecognizer) {
        let touchPoint = sender.location(in: tableView)
        
        guard let indexPath = tableView.indexPathForRow(at: touchPoint) else { return }
        
        CoreDataManager.shared.removePostFrom(favouritePosts: favouritePosts[indexPath.row])
        
        favouritePosts.remove(at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        navigationItem.title = "В избранном \(favouritePosts.count)"
    }
    
    func setupActions() {
        deleteAllButton.target = self
        deleteAllButton.action = #selector(deleteAllButtonTapped)
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
        
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(didPostTapped(_:)))
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        tableView.addGestureRecognizer(doubleTapGestureRecognizer)
    }
}

extension FavouriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return favouritePosts.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: ProfilePostTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                 for: indexPath) as? ProfilePostTableViewCell
        
        cell?.configure(post: favouritePosts[indexPath.row])
        
        return cell ?? UITableViewCell()
    }
}
