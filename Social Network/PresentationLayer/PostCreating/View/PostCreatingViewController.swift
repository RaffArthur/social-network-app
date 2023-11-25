//
//  PostCreatingViewController.swift
//  Social_Network
//
//  Created by Arthur Raff on 28.10.2023.
//

import Foundation
import UIKit

final class PostCreatingViewController: UIViewController {
    weak var delegate: PostCreatingViewControllerDelegate?
    
    private lazy var service = Services.userPostsService()
    
    private lazy var postCreatingView = PostCreatingView()
    
    private lazy var cancelCreatingPostButton: UIBarButtonItem = {
        let bbi = UIBarButtonItem()
        bbi.image = UIImage(systemName: "xmark")
        bbi.tintColor = .SocialNetworkColor.accent
        
        return bbi
    }()
    
    private lazy var publishPostButton: UIBarButtonItem = {
        let bbi = UIBarButtonItem()
        bbi.title = "Опубликовать"
        bbi.tintColor = .SocialNetworkColor.primaryText
        
        return bbi
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view = postCreatingView
        
        postCreatingView.delegate = self
        
        setupScreen()
        setupActions()
    }
}

private extension PostCreatingViewController {
    func setupScreen() {
        navigationItem.leftBarButtonItem = cancelCreatingPostButton
        navigationItem.rightBarButtonItem = publishPostButton
    }
}

extension PostCreatingViewController: PostCreatingViewDelegate {
    func addImageButtonWasTapped() {
        print("изображение добавлено")
    }
}

private extension PostCreatingViewController {
    @objc func cancelCreatingPostButtonWasTapped() {
        delegate?.cancelCreatingPostButtonWasTapped()
    }
    
    @objc func publishPostButtonWasTapped() {
        let userPost = UserPost(id: String(),
                                body: postCreatingView.commentText,
                                image: String(),
                                postLikes: [],
                                postComments: [],
                                postFavourites: [])
        
        service.saveUserPost(userPost: userPost) { [weak self] result in
            switch result {
            case .success:
                self?.delegate?.publishPostButtonWasTapped()
            case .failure(let error):
                self?.show(error: error)
            }
        }
    }
    
    func setupActions() {
        cancelCreatingPostButton.action = #selector(cancelCreatingPostButtonWasTapped)
        cancelCreatingPostButton.target = self
        
        publishPostButton.action = #selector(publishPostButtonWasTapped)
        publishPostButton.target = self
    }
    
    func show(error: UserPostError) {
        let alertController = UIAlertController(title: error.title,
                                                 message: error.message,
                                                 preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК",
                                   style: .cancel,
                                   handler: nil)
        
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }
}
