//
//  ProfileDetailedInfoViewController.swift
//  Social_Network
//
//  Created by Arthur Raff on 21.10.2023.
//

import Foundation
import UIKit

final class ProfileDetailedInfoViewController: UIViewController {
    private lazy var profileDetailedInfoView = ProfileDetailedInfoView()
    
    private let service = Services.userDataService()
    
    private lazy var profileDetailedInfoSections: [[ProfileDetailedInfoMenuModel]] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        service.getUserData { [weak self] result in
            switch result {
            case .success(let data):
                guard let name = data.name,
                      let surname = data.surname,
                      let hometwon = data.hometown,
                      let regalia = data.regalia,
                      let birthDate = data.birthDate
                else {
                    return
                }
                
                let sectionZero = [ProfileDetailedInfoMenuModel(icon: "bubble",
                                                                description: "\(String.localized(key: .mainProfileInfoRegaliaTitle)): \(regalia)"),
                                   ProfileDetailedInfoMenuModel(icon: "at",
                                                                description: "@\(name)_\(surname)".lowercased())]
                let sectionOne = [ProfileDetailedInfoMenuModel(icon: "calendar",
                                                               description: "\(String.localized(key: .mainProfileInfoBirthDateTitle)): \(birthDate)"),
                                  ProfileDetailedInfoMenuModel(icon: "house",
                                                               description: "\(String.localized(key: .mainProfileInfoHometownTitle)): \(hometwon)"),
                                  ProfileDetailedInfoMenuModel(icon: "person.circle",
                                                               description: .localizedPlural(key: .userSubscribers, argument: 1))]
                
                self?.profileDetailedInfoSections = [sectionZero, sectionOne]
                
                self?.profileDetailedInfoView.tableViewReloadData()
            case .failure(let error):
                print(error)
            }
        }        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupContent()
        
        profileDetailedInfoView.tableView(delegate: self, dataSource: self)
        profileDetailedInfoView.tableViewReloadData()
    }
    
    override func loadView() {
        view = profileDetailedInfoView
    }
}

private extension ProfileDetailedInfoViewController {
    func setupContent() {
        view.backgroundColor = .SocialNetworkColor.mainBackground
        navigationItem.title = .localized(key: .profileDetailedInfoTitle)
    }
}

extension ProfileDetailedInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let profileDetailedInfoRow = profileDetailedInfoSections[indexPath.section][indexPath.row]
    }
}

extension ProfileDetailedInfoViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return profileDetailedInfoSections.count
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return profileDetailedInfoSections[section].count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: ProfileDetailedInfoTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier ,
                                                 for: indexPath) as? ProfileDetailedInfoTableViewCell
        
        cell?.configure(withModel: profileDetailedInfoSections[indexPath.section][indexPath.row])
        
        return cell ?? UITableViewCell()
    }
}
