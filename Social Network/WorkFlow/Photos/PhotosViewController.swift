//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Arthur Raff on 24.10.2020.
//

import UIKit

@available(iOS 13.0, *)
class PhotosViewController: UIViewController {    
    private lazy var adapter = PhotosAdapter()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PhotosCollectionViewCell.self))
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        cv.isUserInteractionEnabled = true
        
        return cv
    }()
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        adapter.setupData()
        
        adapter.onDataReceive = { [weak self] in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                self.collectionView.reloadData()
            }
        }
        
        setupScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let navigationController = navigationController else { return }
        guard let tabBarController = navigationController.tabBarController else { return }
        
        tabBarController.tabBar.isHidden = true
        navigationController.navigationBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startTimer(timer)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        stopTimer(timer)
    }
}

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
        return adapter.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotosCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCollectionViewCell.self), for: indexPath) as! PhotosCollectionViewCell
        let photo = adapter.dataSource[indexPath.row]
        
        cell.photo = photo
                
        return cell
    }
}

@available(iOS 13.0, *)
extension PhotosViewController {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupContent() {
        title = "Photos Gallery"
        view.backgroundColor = .white
    }
    
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
}

@available(iOS 13.0, *)
extension PhotosViewController {
    @objc private func fireTimer(_ timer: Timer) {
        timeDescription.text = "До обовления данных осталось \(timerCounter) секунд"
        
        if timerCounter > 0 {
            timerCounter -= 1
        } else {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                self.collectionView.reloadData()
            }
            
            timeDescription.text = "Данные обновлены"
            
            stopTimer(timer)
        }
    }
    
    private func startTimer(_ timer: Timer) {
        RunLoop.current.add(timer, forMode: .common)
    }
    
    private func stopTimer(_ timer: Timer) {
        timer.invalidate()
    }
}
