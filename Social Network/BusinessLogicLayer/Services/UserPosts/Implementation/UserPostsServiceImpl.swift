//
//  UserPostsServiceImpl.swift
//  Social_Network
//
//  Created by Arthur Raff on 28.10.2023.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseDatabase

final class UserPostsServiceImpl: UserPostsService {
    private var ref = Database.database().reference()
    
    func saveUserPost(userPost: UserPost, completion: @escaping SaveUserPostResult) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        ref = Database.database(url: "https://social-network-ea509-default-rtdb.firebaseio.com/").reference().child("userStorage")
        
        guard let title  = userPost.title,
              let body = userPost.body,
              let images = userPost.images,
              let likeCount = userPost.likeCount,
              let commentCount = userPost.commentCount
        else {
            return
        }
        
        let inputDataValidationError = userPostsValidation(body: body)
        
        guard inputDataValidationError == nil else {
            inputDataValidationError.flatMap { completion(.failure($0))}
            
            return
        }
        
        let postID = UUID().uuidString
        
        ref.child("user").child(uid).child("posts").child("id:\(postID)").setValue(["title": title,
                                                                                    "body": body,
                                                                                    "images": images,
                                                                                    "likeCount": likeCount,
                                                                                    "commentCount": commentCount])
        completion(.success(userPost))
    }
    
    func getUserPosts(completion: @escaping GetUserPostResult) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ref = Database.database(url: "https://social-network-ea509-default-rtdb.firebaseio.com/").reference().child("userStorage")

        ref.child("user").child(uid).child("posts").observeSingleEvent(of: .value) { snapshot in
            let value = snapshot.value as? NSDictionary
            
            let title = value?["title"] as? String ?? ""
            let body = value?["body"] as? String ?? ""
            let images = value?["images"] as? [String] ?? [""]
            let likeCount = value?["likeCount"] as? Int ?? 0
            let commentCount = value?["commentCount"] as? Int ?? 0
            
            let userPost = UserPost(title: title,
                                    body: body,
                                    images: images,
                                    likeCount: likeCount,
                                    commentCount: commentCount)
            
            completion(.success(userPost))
        } withCancel: { error in
            completion(.failure(.unknownError))
        }
    }
}

private extension UserPostsServiceImpl {
    func userPostsValidation(body: String) -> UserPostError? {
        if body.isEmpty {
            return .emptyBody
        }
        
        return nil
    }
}
