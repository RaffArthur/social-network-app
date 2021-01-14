//
//  PostViewController.swift
//  Navigation
//
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
        
    let showAlertButton: UIButton = {
        let showAlertButton = UIButton()
        showAlertButton.toAutoLayout()
        showAlertButton.backgroundColor = .clear
        showAlertButton.setTitle("Show Alert", for: showAlertButton.state)
        showAlertButton.titleLabel?.font = .systemFont(ofSize: 28, weight: .heavy)
        showAlertButton.titleLabel?.textColor = .white
        showAlertButton.addTarget(self, action: #selector((showAlert(_:))), for: .touchUpInside)
        
        return showAlertButton
    }()
        
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
    
    func setupLayout() {
        view.addSubview(showAlertButton)

        let constraints = [
            showAlertButton.heightAnchor.constraint(equalToConstant: 44),
            showAlertButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            showAlertButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            showAlertButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            showAlertButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "color_set")
        
        setupLayout()
    }
}
