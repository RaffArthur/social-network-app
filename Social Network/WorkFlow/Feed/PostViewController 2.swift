//
//  PostViewController.swift
//  Navigation
//
//

import UIKit

@available(iOS 13.0, *)
class PostViewController: UIViewController {
    weak var coordinator: FeedCoordinator?
    private lazy var showAlertButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Show Alert", for: button.state)
        button.titleLabel?.font = .systemFont(ofSize: 28, weight: .heavy)
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(showDeletingPostAlert), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
    }
}

@available(iOS 13.0, *)
extension PostViewController: ScreenSetupper {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupContent() {
        view.backgroundColor = UIColor(named: "color_set")
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
extension PostViewController: FuncionalitySetupper {
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
