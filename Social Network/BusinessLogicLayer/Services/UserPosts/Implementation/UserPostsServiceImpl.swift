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
                
                comments.insert(Comment(id: id,
                                        userCommentedID: userCommentedID,
                                        userPhoto: userPhoto,
                                        userFullname: userFullname,
                                        text: text,
                                        date: date,
                                        likes: likes),at: 0)
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
                let postCommentsDict = post?["postComments"] as? NSDictionary
                let postLikesDict = post?["postLikes"] as? NSDictionary
                
                var postLikes: [Like] = []
                var postComments: [Comment] = []
                
                postCommentsDict?.forEach { id, comment in
                    let comment = comment as? NSDictionary
                    
                    let id = comment?["id"] as? String ?? ""
                    let userCommentedID = comment?["userCommentedID"] as? String ?? ""
                    let date = comment?["date"] as? String ?? ""
                    let likes = comment?["likes"] as? Int ?? 0
                    let text = comment?["text"] as? String ?? ""
                    let userFullname = comment?["userFullname"] as? String ?? ""
                    let userPhoto = comment?["userPhoto"] as? String ?? ""
                    
                    postComments.insert(Comment(id: id,
                                                userCommentedID: userCommentedID,
                                                userPhoto: userPhoto,
                                                userFullname: userFullname,
                                                text: text,
                                                date: date,
                                                likes: likes),at: 0)
                }
                
                postLikesDict?.forEach { id, like in
                    let like = like as? NSDictionary
                    
                    let id = like?["id"] as? String ?? ""
                    let likedUserID = like?["userLikedID"] as? String ?? ""
                    let isLiked = like?["isLiked"] as? Bool ?? false

                    
                    postLikes.insert(Like(id: id,
                                          likedUserID: likedUserID,
                                          isLiked: isLiked), at: 0)
                }
                
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
    
    func savePostLike(userID: String,
                      postID: String,
                      isLiked: Bool,
                      completion: @escaping SavePostLikeResult) {
        guard let uid = Auth.auth().currentUser?.uid,
              let childAutoID = ref.childByAutoId().key
        else {
            return
        }
        
        let dict = ["id": childAutoID,
                    "userLikedID": uid,
                    "isLiked": isLiked] as [String : Any]
        
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
    
    func getPostLikes(postID: String,
                      completion: @escaping GetPostLikesResult) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ref = Database.database(url: "https://social-network-ea509-default-rtdb.firebaseio.com/").reference()
            .child("userStorage")
            .child("user")
            .child(uid)
            .child("posts")
            .child(postID)
            .child("postLikes")
        
        ref.observeSingleEvent(of: .value) { snapshot in
            let postLikesDict = snapshot.value as? NSDictionary
            
            var postLikes = [Like]()
            
            postLikesDict?.forEach { id, like in
                let like = like as? NSDictionary
                
                let id = like?[""] as? String ?? ""
                let likedUserID = like?[""] as? String ?? ""
                let isLiked = like?["isLiked"] as? Bool ?? false
                
                postLikes.insert(Like(id: id,
                                      likedUserID: likedUserID,
                                      isLiked: isLiked), at: 0)
            }
        }
    }
    
    func removePostLike(userID: String,
                        postID: String,
                        likeID: String) {
        ref = Database.database(url: "https://social-network-ea509-default-rtdb.firebaseio.com/").reference()
            .child("userStorage")
            .child("user")
            .child(userID)
            .child("posts")
            .child(postID)
            .child("postLikes")
            .child(likeID)
        
        ref.removeValue()
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
