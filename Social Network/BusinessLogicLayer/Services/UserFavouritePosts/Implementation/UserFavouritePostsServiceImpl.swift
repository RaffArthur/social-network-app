//
//  UserFavouritePostsServiceImpl.swift
//  Social_Network
//
//  Created by Arthur Raff on 29.10.2023.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseDatabase

final class UserFavouritePostsServiceImpl: UserFavouritePostsService {
    private var ref = Database.database().reference()

    func addUserPostToFavourite(userPost: UserPost,
                                completion: @escaping SaveToFavouriteUserPostResult) {
        guard let childAutoID = ref.childByAutoId().key,
              let uid = Auth.auth().currentUser?.uid
        else {
            return
        }
        
        ref = Database.database(url: "https://social-network-ea509-default-rtdb.firebaseio.com/").reference()
            .child("userStorage")
            .child("user")
            .child(uid)
            .child("favouritePosts")
            .child(childAutoID)
        
        guard let id = userPost.id,
              let body = userPost.body
        else {
            return
        }
        
        let dict = ["id" : id,
                    "body": body] as [String: Any]
        
        ref.setValue(dict)
        
        completion(.success(userPost))
    }
    
    func getUserFavouritePosts(completion: @escaping GetUserFavouritePostsResult) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ref = Database.database(url: "https://social-network-ea509-default-rtdb.firebaseio.com/").reference()
            .child("userStorage")
            .child("user")
            .child(uid)
            .child("favouritePosts")
        
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
                    let subcommentsDict = comment?["subcomments"] as? NSDictionary
                    
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
                    
                    postLikes.insert(Like(id: id,
                                          likedUserID: likedUserID), at: 0)
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
    
    func removeUserPostFromFavourite(favouritePostID: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        ref = Database.database(url: "https://social-network-ea509-default-rtdb.firebaseio.com/").reference()
            .child("userStorage")
            .child("user")
            .child(uid)
            .child("favouritePosts")
            .child(favouritePostID)
        
        ref.removeValue()
    }
    
    func removeAllUserPostFromFavourite() {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        ref = Database.database(url: "https://social-network-ea509-default-rtdb.firebaseio.com/").reference()
            .child("userStorage")
            .child("user")
            .child(uid)
            .child("favouritePosts")
        
        ref.removeValue()
    }
}
