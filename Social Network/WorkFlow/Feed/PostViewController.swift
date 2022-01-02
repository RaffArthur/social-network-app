//
//  PostViewController.swift
//  Navigation
//
//

import UIKit

@available(iOS 13.0, *)
class PostViewController: UIViewController {
    private lazy var showAlertButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Show Alert", for: button.state)
        button.setTitleColor(UIColor(named: "color_set"), for: button.state)
        button.titleLabel?.font = .systemFont(ofSize: 28, weight: .heavy)
        button.addTarget(self, action: #selector(showDeletingPostAlert), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let navigationController = navigationController else { return }
        navigationController.tabBarController?.tabBar.isHidden = true
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//        guard let navigationController = navigationController else { return }
//        navigationController.tabBarController?.tabBar.isHidden = false
//    }
}

@available(iOS 13.0, *)
extension PostViewController {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupContent() {
        view.backgroundColor = .white
    }
    
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
}

@available(iOS 13.0, *)
extension PostViewController {
    @objc private func showDeletingPostAlert() {
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
