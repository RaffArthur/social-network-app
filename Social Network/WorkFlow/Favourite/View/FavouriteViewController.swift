//
//  FeedViewController.swift
//  Navigation
//
//

import UIKit

final class FavouriteViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(ProfilePostTableViewCell.self,
                           forCellReuseIdentifier: String(describing: ProfilePostTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
                
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
    }
}

private extension FavouriteViewController {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupContent() {
        view.backgroundColor = .white
    }
    
    func setupLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension FavouriteViewController: UITableViewDelegate {
    
}

extension FavouriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return ProfilePostTableViewCell()
    }
}
