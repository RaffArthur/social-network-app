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
    
    func getFavouritePosts(failure: @escaping UserPostFailureBlock,
                           success: @escaping UserPostsSuccessBlock) {
        guard let uid = Auth.auth().currentUser?.uid else {
            failure(.currentUserIDMissing)
            return
        }
        
        var favouritePosts: [UserPost] = []
        
        getUserPosts { error in
            failure(error)
        } success: { userPosts in
            let userFavoritePosts = userPosts.filter { post in
                if let postFavourites = post.postFavourites {
                    return postFavourites.contains(where: { $0.addedToFavouriteUserID == uid })
                }
                return false
            }

            favouritePosts = userFavoritePosts
            
            success(favouritePosts)
        }
    }
    
    func saveToFavourite(userID: String,
                         postID: String,
                         isAddedToFavourite: Bool,
                         failure: @escaping UserPostFailureBlock,
                         success: @escaping PostSuccessBlock) {
        guard let uid = Auth.auth().currentUser?.uid else {
            failure(.currentUserIDMissing)
            return
        }
        
        guard let childAutoID = ref.childByAutoId().key else {
            failure(.childByAutoIDMissing)
            return
        }
        
        let dict = ["id": childAutoID,
                    "addedToFavouriteUserID": uid,
                    "isAddedToFavourite": isAddedToFavourite] as [String : Any]
        
        ref = Database.database(url: "https://social-network-ea509-default-rtdb.firebaseio.com/").reference()
            .child("userStorage")
            .child("user")
            .child(userID)
            .child("posts")
            .child(postID)
            .child("postFavourites")
            .child(childAutoID)
        
        ref.setValue(dict) { error, ref in
            if let error = error as? FirebaseDatabaseError {
                failure(error)
            } else {
                success(childAutoID)
            }
        }
    }
    
    func removeFromFavourite(userID: String,
                             postID: String,
                             favouriteID: String,
                             failure: @escaping UserPostFailureBlock,
                             success: @escaping PostSuccessBlock) {
        ref = Database.database(url: "https://social-network-ea509-default-rtdb.firebaseio.com/").reference()
            .child("userStorage")
            .child("user")
            .child(userID)
            .child("posts")
            .child(postID)
            .child("postFavourites")
            .child(favouriteID)
        
        ref.removeValue { error, ref in
            if let error = error as? FirebaseDatabaseError {
                failure(error)
            } else {
                success(favouriteID)
            }
        }
    }
    
    func saveUserComment(comment: Comment,
                         userID: String,
                         postID: String,
                         failure: @escaping UserPostFailureBlock,
                         success: @escaping CommentSuccessBlock) {
        guard let uid = Auth.auth().currentUser?.uid else {
            failure(.currentUserIDMissing)
            return
        }
        
        guard let childAutoID = ref.childByAutoId().key else {
            failure(.childByAutoIDMissing)
            return
        }
        
        ref = Database.database(url: "https://social-network-ea509-default-rtdb.firebaseio.com/").reference()
            .child("userStorage")
            .child("user")
            .child(userID)
            .child("posts")
            .child(postID)
            .child("postComments")
            .child(childAutoID)
        
        guard let userPhoto = comment.userPhoto,
              let userFullname = comment.userFullname,
              let text = comment.text,
              let date = comment.date,
              let likes = comment.likes
        else {
            return
        }
        
        let dict = ["id": childAutoID,
                    "userCommentedID": uid,
                    "userPhoto": userPhoto,
                    "userFullname": userFullname,
                    "text": text,
                    "date": date,
                    "likes": likes] as [String : Any]
        
        ref.setValue(dict) { error, ref in
            if let error = error as? FirebaseDatabaseError {
                failure(error)
            } else {
                success(childAutoID)
            }
        }
        
    }
    
    func getPostComments(postID: String,
                         failure: @escaping UserPostFailureBlock,
                         success: @escaping PostCommentsSuccessBlock) {
        guard let uid = Auth.auth().currentUser?.uid else {
            failure(.currentUserIDMissing)
            return
        }
        
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
            
            success(comments)
        } withCancel: { error in
            if let error = error as? FirebaseDatabaseError {
                failure(error)
            }
        }
    }
    
    func saveUserPost(userPost: UserPost,
                      failure: @escaping UserPostFailureBlock,
                      success: @escaping PostSuccessBlock) {
        guard let uid = Auth.auth().currentUser?.uid else {
            failure(.currentUserIDMissing)
            return
        }
        
        guard let childAutoID = ref.childByAutoId().key else {
            failure(.childByAutoIDMissing)
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
            inputDataValidationError.flatMap { failure($0) }
            
            return
        }
                
        let dict = ["id" : childAutoID,
                    "body": body,
                    "image": image,
                    "postLikes": postLikes,
                    "postComments": postComments,] as [String: Any]
        
        
        ref.setValue(dict) { error, ref in
            if let error = error as? FirebaseDatabaseError {
                failure(error)
            } else {
                success(childAutoID)
            }
        }
    }
    
    func getUserPosts(failure: @escaping UserPostFailureBlock,
                      success: @escaping UserPostsSuccessBlock) {
        guard let uid = Auth.auth().currentUser?.uid else {
            failure(.currentUserIDMissing)
            return
        }
        
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
                let postFavouritesDict = post?["postFavourites"] as? NSDictionary
                
                var postLikes: [Like] = []
                var postComments: [Comment] = []
                var postFavourites: [Favourite] = []
                
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
                
                postFavouritesDict?.forEach { id, favourite in
                    let favourite = favourite as? NSDictionary
                    
                    let id = favourite?["id"] as? String ?? ""
                    let addedToFavouriteUserID = favourite?["addedToFavouriteUserID"] as? String ?? ""
                    let isAddedToFavourite = favourite?["isAddedToFavourite"] as? Bool ?? false
                    
                    postFavourites.insert(Favourite(id: id,
                                                    addedToFavouriteUserID: addedToFavouriteUserID,
                                                    isAddedToFavourite: isAddedToFavourite), at: 0)
                }
                
                userPosts.insert(UserPost(id: id,
                                          body: body,
                                          image: image,
                                          postLikes: postLikes,
                                          postComments: postComments,
                                          postFavourites: postFavourites), at: 0)
            }
            
            success(userPosts)
        } withCancel: { error in
            if let error = error as? FirebaseDatabaseError {
                failure(error)
            }
        }
    }
    
    func savePostLike(userID: String,
                      postID: String,
                      isLiked: Bool,
                      failure: @escaping UserPostFailureBlock,
                      success: @escaping LikeSuccessBlock) {
        guard let uid = Auth.auth().currentUser?.uid else {
            failure(.currentUserIDMissing)
            return
        }
        
        guard let childAutoID = ref.childByAutoId().key else {
            failure(.childByAutoIDMissing)
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
        
        ref.setValue(dict) { error, ref in
            if let error = error as? FirebaseDatabaseError {
                failure(error)
            } else {
                success(childAutoID)
            }
        }
    }
    
    func getPostLikes(postID: String,
                      failure: @escaping UserPostFailureBlock,
                      success: @escaping PostLikesSuccessBlock) {
        guard let uid = Auth.auth().currentUser?.uid else {
            failure(.currentUserIDMissing)
            return
        }
        
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
                
                let id = like?["id"] as? String ?? ""
                let likedUserID = like?["likedUserID"] as? String ?? ""
                let isLiked = like?["isLiked"] as? Bool ?? false
                
                postLikes.insert(Like(id: id,
                                      likedUserID: likedUserID,
                                      isLiked: isLiked), at: 0)
                success(postLikes)
            }
        } withCancel: { error in
            if let error = error as? FirebaseDatabaseError {
                failure(error)
            }
        }
    }
    
    func removePostLike(userID: String,
                        postID: String,
                        likeID: String,
                        failure: @escaping UserPostFailureBlock,
                        success: @escaping LikeSuccessBlock) {
        ref = Database.database(url: "https://social-network-ea509-default-rtdb.firebaseio.com/").reference()
            .child("userStorage")
            .child("user")
            .child(userID)
            .child("posts")
            .child(postID)
            .child("postLikes")
            .child(likeID)
        
        ref.removeValue { error, ref in
            if let error = error as? FirebaseDatabaseError {
                failure(error)
            } else {
                success(likeID)
            }
        }
    }
}

private extension UserPostsServiceImpl {
    func userPostsValidation(body: String) -> FirebaseDatabaseError? {
        if body.isEmpty {
            return .emptyBody
        }
        
        return nil
    }
}
