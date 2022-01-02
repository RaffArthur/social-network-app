//
//  FeedContainerView.swift
//  Social_Network
//
//  Created by Arthur Raff on 14.01.2021.
//

import UIKit

@available(iOS 13.0, *)
class FeedContainerView: UIStackView {
    var didSendEventClosure: ((FeedContainerView.Event) -> Void)?

    private lazy var userTitle: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .black)
        label.textAlignment = .center
        label.baselineAdjustment = .alignCenters
        label.numberOfLines = 2
        label.textColor = UIColor(named: "color_set")
        
        return label
    }()
    private lazy var planetOrbitalPeriodLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.baselineAdjustment = .alignCenters
        label.numberOfLines = 2
        label.textColor = .darkGray
        
        return label
    }()
    private lazy var showPostButtonOne: UIButton = {
        let button = UIButton()
        button.setTitle("Post Button One".uppercased(), for: button.state)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .black)
        button.backgroundColor = UIColor(named: "color_set")
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.white.cgColor
        button.isEnabled = true

        return button
    }()
    private lazy var showPostButtonTwo: UIButton = {
        let button = UIButton()
        button.setTitle("Post Button Two".uppercased(), for: button.state)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .black)
        button.backgroundColor = UIColor(named: "color_set")
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.white.cgColor
        button.isEnabled = true
        
        return button
    }()
        
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupDataInFeed()
        setupScreen()
        setupActions()
    }
}

@available(iOS 13.0, *)
extension FeedContainerView {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupContent() {
        
    }
    
    func setupLayout() {
       addSubview(userTitle)
       addSubview(planetOrbitalPeriodLabel)
       addSubview(showPostButtonOne)
       addSubview(showPostButtonTwo)
       
       userTitle.snp.makeConstraints { (make) in
           make.top.equalToSuperview()
           make.leading.equalToSuperview().offset(40)
           make.trailing.equalToSuperview().offset(-40)
           make.bottom.equalTo(planetOrbitalPeriodLabel.snp.top).offset(-24)
       }
       
       planetOrbitalPeriodLabel.snp.makeConstraints { (make) in
           make.leading.equalToSuperview().offset(40)
           make.trailing.equalToSuperview().offset(-40)
           make.bottom.equalTo(showPostButtonOne.snp.top).offset(-24)
       }
       
       showPostButtonOne.snp.makeConstraints { (make) in
           make.height.equalTo(56)
           make.leading.equalToSuperview()
           make.trailing.equalToSuperview()
           make.bottom.equalTo(showPostButtonTwo.snp.top).offset(-24)
       }
       
       showPostButtonTwo.snp.makeConstraints { (make) in
           make.height.equalTo(56)
           make.leading.equalToSuperview()
           make.trailing.equalToSuperview()
           make.bottom.equalToSuperview()
       }
   }
}

@available(iOS 13.0, *)
extension FeedContainerView {
    private func setupDataInFeed() {
        setupTitle()
        setupOrbitalPeriod()
    }

    private func setupTitle() {
        let networkManager = NetworkManager()
        
        if let url = URL(string: "https://jsonplaceholder.typicode.com/todos/5") {
            networkManager.runDataTask(url: url) { data in
                if let result = data {
                    do {
                        let object = try networkManager.returnObject(from: result)
                        if let dictionary = object {
                            let userData = UserDataModel(userID: dictionary["userId"] as? Int ?? -1,
                                                        id: dictionary["id"] as? Int ?? -1,
                                                        title: dictionary["title"] as? String ?? "error",
                                                        completed: dictionary["completed"] as? Bool ?? false)
                            
                            DispatchQueue.main.async { [weak self] in
                                guard let self = self else { return }
                                
                                self.userTitle.text = userData.title
                            }
                        }
                    } catch {
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else { return }
                            
                            self.userTitle.textColor = .red
                            self.userTitle.text = "error"
                        }
                    }
                }
            }
        }
    }
    
    private func setupOrbitalPeriod() {
        let networkManager = NetworkManager()

        if let url = URL(string: "https://swapi.dev/api/planets/10") {
            networkManager.runDataTask(url: url) { data in
                if let result = data {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    if let planet = try? decoder.decode(StarWarsPlanetsModel.self, from: result) {
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else { return }
                            guard let planetName = planet.name else { return }
                            guard let orbitalPeriod = planet.orbitalPeriod else { return }
                            
                            self.planetOrbitalPeriodLabel.text = "Planet: \(planetName) | Orbital period: \(orbitalPeriod)"
                        }
                    } else {
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else { return }

                            self.planetOrbitalPeriodLabel.text = "error"
                            self.planetOrbitalPeriodLabel.textColor = .red
                        }
                    }
                }
            }
        }
    }
        
    @objc private func buttonOnePressed(sender: UIButton!) {
        didSendEventClosure?(.showPostButtonOneTapped)
    }
    
    @objc private func buttonTwoPressed(sender: UIButton!) {
        didSendEventClosure?(.showPostButtonTwoTapped)
    }
}

@available(iOS 13.0, *)
extension FeedContainerView {
    func setupActions() {
        showPostButtonOne.addTarget(self, action: #selector(buttonOnePressed(sender:)), for: .touchUpInside)
        showPostButtonTwo.addTarget(self, action: #selector(buttonTwoPressed(sender:)), for: .touchUpInside)
    }
    
    
}

@available(iOS 13.0, *)
extension FeedContainerView {
    enum Event {
        case showPostButtonOneTapped
        case showPostButtonTwoTapped
    }
}
