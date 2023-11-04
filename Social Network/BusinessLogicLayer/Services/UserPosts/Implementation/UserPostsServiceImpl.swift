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
        
        guard let body = userPost.body
        else {
            return
        }
        
        let inputDataValidationError = userPostsValidation(body: body)
        
        guard inputDataValidationError == nil else {
            inputDataValidationError.flatMap { completion(.failure($0))}
            
            return
        }
        
        let dict = ["body": body,
                    "images": userPost.images ?? [String](),
                    "likeCount": userPost.likeCount ?? Int(),
                    "commentCount": userPost.commentCount ?? Int()] as [String : Any]
        
        ref.child("user").child(uid).child("posts").childByAutoId().setValue(dict)
        
        completion(.success(userPost))
    }
    
    func getUserPosts(completion: @escaping GetUserPostsResult) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ref = Database.database(url: "https://social-network-ea509-default-rtdb.firebaseio.com/").reference().child("userStorage")
        
        
        ref.child("user").child(uid).child("posts").observeSingleEvent(of: .value) { snapshot in
            let values = snapshot.value as? NSDictionary
            
            var userPosts = UserPosts(posts: [:])
            
            values?.forEach { postID, post in
                let post = post as? NSDictionary
                guard let postID = postID as? String else { return }
                
                let body = post?["body"] as? String ?? ""
                let images = post?["images"] as? [String] ?? [""]
                let likeCount = post?["likeCount"] as? Int ?? 0
                let commentCount = post?["commentCount"] as? Int ?? 0
                
                userPosts.posts?.updateValue(UserPost(body: body,
                                                     images: images,
                                                     likeCount: likeCount,
                                                     commentCount: commentCount), forKey: postID)
            }
            
            completion(.success(userPosts))
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
