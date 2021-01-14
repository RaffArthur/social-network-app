//
//  InfoViewController.swift
//  Navigation
//
//

import UIKit

@available(iOS 13.0, *)
class InfoViewController: UIViewController {
    
    // MARK: - View Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addNewPostButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .done,
            target: self,
            action: #selector(self.addNewPost)
        )
        
        title = "New Post!"
        view.backgroundColor = UIColor(named: "color_set")

        navigationController?.navigationBar.isHidden = false
        self.navigationItem.setRightBarButton(addNewPostButtonItem, animated: true)
    }
    
    // MARK: - @objc Actions
    @objc func addNewPost(_ sender: UIBarButtonItem) {
        navigationController?.present(PostViewController(), animated: true, completion: nil)
    }
}
