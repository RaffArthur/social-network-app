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
    
    func saveUserComment(comment: Comment,
                         userID: String,
                         postID: String,
                         completion: @escaping SaveUserPostResult) {
        guard let childAutoID = ref.childByAutoId().key else { return }
        
        ref = Database.database(url: "https://social-network-ea509-default-rtdb.firebaseio.com/").reference()
            .child("userStorage")
            .child("user")
            .child(userID)
            .child("posts")
            .child(postID)
            .child("postComments")
            .child(childAutoID)
        
        guard let userCommentedID = comment.userCommentedID,
              let userPhoto = comment.userPhoto,
              let userFullname = comment.userFullname,
              let text = comment.text,
              let date = comment.date,
              let likes = comment.likes
        else {
            return
        }
        
        let dict = ["id": childAutoID,
                    "userCommentedID": userCommentedID,
                    "userPhoto": userPhoto,
                    "userFullname": userFullname,
                    "text": text,
                    "date": date,
                    "likes": likes] as [String : Any]

        ref.setValue(dict)
        
        completion(.success(dict))
    }
    
    func getPostComments(postID: String,
                         completion: @escaping GetPostCommentsResult) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ref = Database.database(url: "https://social-network-ea509-default-rtdb.firebaseio.com/").reference()
            .child("userStorage")
            .child("user")
            .child(uid)
            .child("posts")
            .child(postID)
            .child("postComments")
        
        ref.observeSingleEvent(of: .value) { snapshot in
            let commentsDict = snapshot.value as? NSDictionary

            var comments = [Comment]()
            
            commentsDict?.forEach { id, comment in
                let comment = comment as? NSDictionary
                
                let id = comment?["id"] as? String ?? ""
                let userCommentedID = comment?["userCommentedID"] as? String ?? ""
                let date = comment?["date"] as? String ?? ""
                let likes = comment?["likes"] as? Int ?? 0
                let text = comment?["text"] as? String ?? ""
                let userFullname = comment?["userFullname"] as? String ?? ""
                let userPhoto = comment?["userPhoto"] as? String ?? ""
                let subcommentsDict = comment?["subcomments"] as? NSDictionary
                
                var subcomments = [Subcomment]()
                
                subcommentsDict?.forEach { id, subcomment in
                    let subcomment = subcomment as? NSDictionary
                    
                    let id = subcomment?["id"] as? String ?? ""
                    let userSubcommentedID = subcomment?["userSubcommentedID"] as? String ?? ""
                    let userPhoto = subcomment?["userPhoto"] as? String ?? ""
                    let userFullname = subcomment?["userFullname"] as? String ?? ""
                    let text = subcomment?["text"] as? String ?? ""
                    let date = subcomment?["date"] as? String ?? ""
                    let likes = subcomment?["likes"] as? Int ?? 0
                    
                    subcomments.insert(Subcomment(id: id,
                                                  userSubcommentedID: userSubcommentedID,
                                                  userPhoto: userPhoto,
                                                  userFullname: userFullname,
                                                  text: text,
                                                  date: date,
                                                  likes: likes), at: 0)
                }
                
                comments.insert(Comment(id: id,
                                        userCommentedID: userCommentedID,
                                        userPhoto: userPhoto,
                                        userFullname: userFullname,
                                        text: text,
                                        date: date,
                                        likes: likes,
                                        subcomments: subcomments),at: 0)
            }
            
            completion(.success(comments))
        } withCancel: { error in
            completion(.failure(.unknownError))
        }
    }
        
    func saveUserPost(userPost: UserPost,
                      completion: @escaping SaveUserPostResult) {
        guard let childAutoID = ref.childByAutoId().key,
              let uid = Auth.auth().currentUser?.uid
        else {
            return
        }

        ref = Database.database(url: "https://social-network-ea509-default-rtdb.firebaseio.com/").reference()
            .child("userStorage")
            .child("user")
            .child(uid)
            .child("posts")
            .child(childAutoID)
        
        guard let body = userPost.body,
              let image = userPost.image,
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
                
        let dict = ["id" : childAutoID,
                    "body": body,
                    "image": image,
                    "postLikes": postLikes,
                    "postComments": postComments,] as [String: Any]
        
        
        ref.setValue(dict)
        
        completion(.success(userPost))
    }
    
    func getUserPosts(completion: @escaping GetUserPostsResult) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ref = Database.database(url: "https://social-network-ea509-default-rtdb.firebaseio.com/").reference()
            .child("userStorage")
            .child("user")
            .child(uid)
            .child("posts")
        
        ref.observeSingleEvent(of: .value) { snapshot in
            let postsDict = snapshot.value as? NSDictionary
            
            var userPosts: [UserPost] = []
            
            postsDict?.forEach { id, post in
                let post = post as? NSDictionary
                
                let id = post?["id"] as? String ?? ""
                let body = post?["body"] as? String ?? ""
                let image = post?["image"] as? String ?? ""
                
                var postLikes: [Like] = []
                var postComments: [Comment] = []

                                
                userPosts.insert(UserPost(id: id,
                                          body: body,
                                          image: image,
                                          postLikes: postLikes,
                                          postComments: postComments), at: 0)
            }
            
            completion(.success(userPosts))
        } withCancel: { error in
            completion(.failure(.unknownError))
        }
    }
    
    func trackUserLike(like: Like,
                       userID: String,
                       postID: String,
                       completion: @escaping TrackPostLikeResult) {
        guard let uid = Auth.auth().currentUser?.uid,
              let childAutoID = ref.childByAutoId().key
        else {
            return
        }
        
        let dict = ["id": childAutoID,
                    "userLikedID": uid]
        
        ref = Database.database(url: "https://social-network-ea509-default-rtdb.firebaseio.com/").reference()
            .child("userStorage")
            .child("user")
            .child(userID)
            .child("posts")
            .child(postID)
            .child("postLikes")
            .child(childAutoID)
        
        ref.setValue(dict)
        
        completion(.success(dict))
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
