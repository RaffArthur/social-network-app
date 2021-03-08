//
//  PostViewController.swift
//  Navigation
//
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class PostViewController: UIViewController {
    
    // MARK: - Properties
    weak var coordinator: FeedCoordinator?
    
    let showAlertButton: UIButton = {
        let showAlertButton = UIButton()
        showAlertButton.backgroundColor = .clear
        showAlertButton.setTitle("Show Alert", for: showAlertButton.state)
        showAlertButton.titleLabel?.font = .systemFont(ofSize: 28, weight: .heavy)
        showAlertButton.titleLabel?.textColor = .white
        showAlertButton.addTarget(self, action: #selector((showAlert(_:))), for: .touchUpInside)
        
        return showAlertButton
    }()
    
    // MARK: - View Funcs
    func setupLayout() {
        view.addSubview(showAlertButton)
        
        showAlertButton.snp.makeConstraints { (make) in
            make.height.equalTo(44)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(view.safeAreaLayoutGuide.snp.centerY)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "color_set")
        
        setupLayout()
    }

    // MARK: - @objc Actions
    @objc func showAlert(_ sender: Any) {
        let alertController = UIAlertController(title: "Удалить пост?", message: "Пост нельзя будет восстановить", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { _ in
            print("Отмена")
        }
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            print("Удалить")
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
