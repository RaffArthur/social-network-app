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
    
    private lazy var userPostsService = Services.userPostsService()
    
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
        postCreatingView.textView(delegate: self)
        
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
        
        userPostsService.saveUserPost(userPost: userPost) { [weak self] error in
            self?.show(error: .emptyBody)
        } success: { [weak self] postID in
            self?.delegate?.publishPostButtonWasTapped()
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

extension PostCreatingViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        postCreatingView.textView(isEditing: !textView.text.isEmpty)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        postCreatingView.textView(isEditing: true)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        postCreatingView.textView(isEditing: !textView.text.isEmpty)
    }
}
