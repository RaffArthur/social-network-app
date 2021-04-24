//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Arthur Raff on 24.10.2020.
//

import UIKit
import SwiftyJSON

@available(iOS 13.0, *)
class PhotosViewController: UIViewController {
    // MARK: - Properties
    weak var coordinator: ProfileCoordinator?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PhotosCollectionViewCell.self))
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        
        return cv
    }()
    
    var photoURLs: [String] = []
    
    private lazy var timer = Timer(timeInterval: 1.0,
                      target: self,
                      selector: #selector(fireTimer),
                      userInfo: nil,
                      repeats: true)
    private lazy var timerCounter = 5
    private lazy var timeDescription: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.textAlignment = .center
        label.backgroundColor = .white
        
        return label
    }()
    
    // MARK: - Layout Funcs
    func setupLayout() {
        view.addSubview(timeDescription)
        view.addSubview(collectionView)
        
        timeDescription.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(timeDescription.snp.bottom).offset(24)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        getURLsFromServer { result in
            switch result {
            case .success(let urls):
                self.photoURLs = urls
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                apiErrorHandler(error: error, vc: self)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Photos Gallery"
        view.backgroundColor = .white
        
        coordinator?.navigationController.tabBarController?.tabBar.isHidden = true
        coordinator?.navigationController.navigationBar.isHidden = false
        coordinator?.navigationController.hidesBarsOnSwipe = true
        
        setupLayout()
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        stopTimer(timer)
    }
    
    // MARK: - JSON Parsing
    func getURLsFromServer(completion: @escaping (Result<[String], ApiErrors>) -> Void) {
        var urlsFromServer: [String] = []
        
        if let url = URL(string:"https://jsonplaceholder.typicode.com/photos") {
            let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard let data = data else { return }
                
                if let vc = self {
                    urlsFromServer = vc.parseJSON(data)
                }
                
                if urlsFromServer.isEmpty {
                    completion(.failure(.dataNotFound))
                } else {
                    completion(.success(urlsFromServer))
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> [String] {
        var urlsFromJSON: [String] = []
        
        let json = JSON(data)
        
        for (_, element) in json.enumerated() {
            if let url = element.1["url"].string {
                urlsFromJSON.append(url)
            }
        }
        
        return urlsFromJSON
    }
    
    // MARK: - Timer creating
    @objc private func fireTimer(_ timer: Timer) {
        timeDescription.text = "До обовления данных осталось \(timerCounter) секунд"
        
        if timerCounter > 0 {
            timerCounter -= 1
        } else {
            self.collectionView.reloadData()
            
            timeDescription.text = "Данные обновлены"
            
            stopTimer(timer)
        }
    }
    
    private func startTimer() {
        RunLoop.current.add(timer, forMode: .common)
    }
    
    private func stopTimer(_ timer: Timer) {
        timer.invalidate()
    }
}


// MARK: - Extensions
@available(iOS 13.0, *)
extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    var offset: CGFloat { return 8 }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.bounds.width - offset * 4) / 3
        let height: CGFloat = collectionView.bounds.width / 3
        
        return .init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return offset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return offset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}

@available(iOS 13.0, *)
extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                
        return photoURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotosCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCollectionViewCell.self), for: indexPath) as! PhotosCollectionViewCell
        
        cell.getPhoto(from: self.photoURLs[indexPath.item])
                
        return cell
    }
}
