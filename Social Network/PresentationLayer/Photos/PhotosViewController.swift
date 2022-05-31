//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Arthur Raff on 24.10.2020.
//

import UIKit

final class PhotosViewController: UIViewController {
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
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemGray
        label.textAlignment = .center
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        navigationController?.tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = false
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

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    var offset: CGFloat { return 8 }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = CGFloat((collectionView.bounds.width - offset * 5) / 4)
        let height = CGFloat(collectionView.bounds.width / 4)
        
        return .init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return offset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return offset
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Storages.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotosCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCollectionViewCell.self), for: indexPath) as! PhotosCollectionViewCell
        let photo = Storages.photos[indexPath.row]
        
        cell.photo = photo
                
        return cell
    }
}

private extension PhotosViewController {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupContent() {
        title = "Photos Gallery"
        view.backgroundColor = .white
    }
    
    func setupLayout() {
        view.add(subviews: [timeDescription,
                            collectionView])
        
        timeDescription.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.centerX.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(timeDescription.snp.bottom).offset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-8)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

private extension PhotosViewController {
    @objc private func fireTimer(_ timer: Timer) {
        timeDescription.text = "Обновление через \(timerCounter) сек."
        
        if timerCounter > 0 {
            timerCounter -= 1
        } else {
            collectionView.reloadData()
            
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
