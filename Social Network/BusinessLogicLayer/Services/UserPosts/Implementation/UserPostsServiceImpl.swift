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
        
        let postUUID = UUID().uuidString
        
        ref.child("user").child(uid).child("posts").child("\(postUUID)").setValue(["body": body,
                                                                                   "images": userPost.images ?? [String](),
                                                                                   "likeCount": userPost.likeCount ?? Int(),
                                                                                   "commentCount": userPost.commentCount ?? Int()])
        
        completion(.success(userPost))
    }
    
    func getUserPosts(completion: @escaping GetUserPostsResult) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ref = Database.database(url: "https://social-network-ea509-default-rtdb.firebaseio.com/").reference().child("userStorage")
        
        
        ref.child("user").child(uid).child("posts").observeSingleEvent(of: .value) { snapshot in
            let values = snapshot.value as? NSDictionary
            
            var userPosts = [UserPost]()
            
            values?.forEach { key, value in
                let value = value as? NSDictionary
                
                let body = value?["body"] as? String ?? ""
                let images = value?["images"] as? [String] ?? [""]
                let likeCount = value?["likeCount"] as? Int ?? 0
                let commentCount = value?["commentCount"] as? Int ?? 0
                
                userPosts.insert(UserPost(body: body,
                                          images: images,
                                          likeCount: likeCount,
                                          commentCount: commentCount), at: 0)
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
