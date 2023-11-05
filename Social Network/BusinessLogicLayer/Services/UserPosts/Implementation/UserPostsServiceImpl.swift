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

    func getPostComments(postID: String, completion: @escaping GetPostCommentsResult) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ref = Database.database(url: "https://social-network-ea509-default-rtdb.firebaseio.com/").reference().child("userStorage")
        
        ref.child("user").child(uid).child("posts").child(postID).child("postComments").observeSingleEvent(of: .value) { snapshot in
            let values = snapshot.value as? NSDictionary

            var comments = [Comment]()
            
            values?.forEach { id, comment in
                let comment = comment as? NSDictionary
                                
                let date = comment?["date"] as? String ?? ""
                let likes = comment?["likes"] as? Int ?? 0
                let text = comment?["text"] as? String ?? ""
                let userFullname = comment?["userFullname"] as? String ?? ""
                let userID = comment?["userID"] as? String ?? ""
                let userPhoto = comment?["userPhoto"] as? String ?? ""
                
                comments.insert(Comment(userID: "",
                                        userPhoto: userPhoto,
                                        userFullname: userFullname,
                                        text: text,
                                        date: date,
                                        likes: likes), at: 0)
            }
            
            completion(.success(comments))
        } withCancel: { error in
            completion(.failure(.unknownError))
        }
    }
    
    func saveUserComment(comment: Comment,
                         userID: String,
                         postID: String,
                         completion: @escaping SaveUserPostResult) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ref = Database.database(url: "https://social-network-ea509-default-rtdb.firebaseio.com/").reference().child("userStorage")
        
        guard let userID = comment.userID,
              let userPhoto = comment.userPhoto,
              let userFullname = comment.userFullname,
              let text = comment.text,
              let date = comment.date,
              let likes = comment.likes
        else {
            return
        }
        
        let dict = ["userID": userID,
                    "userPhoto": userPhoto,
                    "userFullname": userFullname,
                    "text": text,
                    "date": date,
                    "likes": likes] as [String : Any]

        ref.child("user").child(userID).child("posts").child(postID).child("postComments").childByAutoId().setValue(dict)
        
        completion(.success(comment))
    }
    
    func saveUserPost(userPost: UserPost, completion: @escaping SaveUserPostResult) {
        ref = Database.database(url: "https://social-network-ea509-default-rtdb.firebaseio.com/").reference().child("userStorage")
        
        guard let uid = Auth.auth().currentUser?.uid,
              let body = userPost.body,
              let images = userPost.images,
              let postLikes = userPost.postLikes,
              let postComments = userPost.postComments
        else {
            return
        }
        
        let inputDataValidationError = userPostsValidation(body: body)
        
        guard inputDataValidationError == nil else {
            inputDataValidationError.flatMap { completion(.failure($0))}
            
            return
        }
                
        let dict = ["body": body,
                    "images": images,
                    "postLikes": postLikes,
                    "postComments": postComments,] as [String: Any]
        
        
        ref.child("user").child(uid).child("posts").childByAutoId().setValue(dict)
        
        completion(.success(userPost))
    }
    
    func likeAUsersPost(userID: String, postID: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ref = Database.database(url: "https://social-network-ea509-default-rtdb.firebaseio.com/").reference().child("userStorage")
        
        
        ref.child("user").child(userID).child("posts").child(postID).child("postLikes").setValue([uid])
    }
    
    func dislikeAUsersPost(userID: String, postID: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ref = Database.database(url: "https://social-network-ea509-default-rtdb.firebaseio.com/").reference().child("userStorage")
        
        ref.child("user").child(userID).child("posts").child(postID).child("postLikes").child(uid).removeValue()
    }
    
    func getUserPosts(completion: @escaping GetUserPostsResult) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ref = Database.database(url: "https://social-network-ea509-default-rtdb.firebaseio.com/").reference().child("userStorage")
        
        
        ref.child("user").child(uid).child("posts").observeSingleEvent(of: .value) { snapshot in
            let values = snapshot.value as? NSDictionary

            var userPosts = UserPosts(post: [:])
            
            values?.forEach { id, post in
                let post = post as? NSDictionary
                guard let postID = id as? String else { return }
                
                let body = post?["body"] as? String ?? ""
                let images = post?["images"] as? [String] ?? [""]
                let postLikes = post?["postLikes"] as? [String] ?? [""]
                let postComments = post?["postComments"] as? [String: Comment] ?? [:]
                
                userPosts.post?.updateValue(UserPost(body: body,
                                                     images: images,
                                                     postLikes: postLikes,
                                                     postComments: postComments),
                                             forKey: postID)
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
