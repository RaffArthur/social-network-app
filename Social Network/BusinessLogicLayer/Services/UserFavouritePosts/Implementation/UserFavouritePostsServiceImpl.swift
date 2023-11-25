//
//  UserFavouritePostsServiceImpl.swift
//  Social_Network
//
//  Created by Arthur Raff on 29.10.2023.
//

//import Foundation
//import Firebase
//import FirebaseFirestore
//import FirebaseDatabase
//
//final class UserFavouritePostsServiceImpl: UserFavouritePostsService {
//    private var ref = Database.database().reference()
//
//    func addUserPostToFavourite(userPost: UserPost,
//                                completion: @escaping SaveToFavouriteUserPostResult) {
//        guard let childAutoID = ref.childByAutoId().key,
//              let uid = Auth.auth().currentUser?.uid
//        else {
//            return
//        }
//        
//        ref = Database.database(url: "https://social-network-ea509-default-rtdb.firebaseio.com/").reference()
//            .child("userStorage")
//            .child("user")
//            .child(uid)
//            .child("favouritePosts")
//            .child(childAutoID)
//                
//        let dict = ["id": userPost.id ?? "",
//                    "body": userPost.body ?? "",
//                    "image": userPost.image ?? "",
//                    "postLikes": likesArray(from: userPost.postLikes),
//                    "postComments": commentsArray(from: userPost.postComments)] as [String: Any]
//        
//        ref.setValue(dict)
//        
//        completion(.success(userPost))
//    }
//    
//    func getUserFavouritePosts(completion: @escaping GetUserFavouritePostsResult) {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        
//        ref = Database.database(url: "https://social-network-ea509-default-rtdb.firebaseio.com/").reference()
//            .child("userStorage")
//            .child("user")
//            .child(uid)
//            .child("favouritePosts")
//        
//        ref.observeSingleEvent(of: .value) { snapshot in
//            let postsDict = snapshot.value as? NSDictionary
//            
//            var userPosts: [UserPost] = []
//            
//            postsDict?.forEach { id, post in
//                let post = post as? NSDictionary
//                
//                let id = post?["id"] as? String ?? ""
//                let body = post?["body"] as? String ?? ""
//                let image = post?["image"] as? String ?? ""
//                let postCommentsDict = post?["postComments"] as? NSDictionary
//                let postLikesDict = post?["postLikes"] as? NSDictionary
//                
//                var postLikes: [Like] = []
//                var postComments: [Comment] = []
//                
//                postCommentsDict?.forEach { id, comment in
//                    let comment = comment as? NSDictionary
//                    
//                    let id = comment?["id"] as? String ?? ""
//                    let userCommentedID = comment?["userCommentedID"] as? String ?? ""
//                    let date = comment?["date"] as? String ?? ""
//                    let likes = comment?["likes"] as? Int ?? 0
//                    let text = comment?["text"] as? String ?? ""
//                    let userFullname = comment?["userFullname"] as? String ?? ""
//                    let userPhoto = comment?["userPhoto"] as? String ?? ""
//                    
//                    postComments.insert(Comment(id: id,
//                                                userCommentedID: userCommentedID,
//                                                userPhoto: userPhoto,
//                                                userFullname: userFullname,
//                                                text: text,
//                                                date: date,
//                                                likes: likes),at: 0)
//                }
//                
//                postLikesDict?.forEach { id, like in
//                    let like = like as? NSDictionary
//                    
//                    let id = like?["id"] as? String ?? ""
//                    let likedUserID = like?["userLikedID"] as? String ?? ""
//                    let isLiked = like?["isLiked"] as? Bool ?? false
//                    
//                    postLikes.insert(Like(id: id,
//                                          likedUserID: likedUserID,
//                                          isLiked: isLiked), at: 0)
//                }
//                
//                userPosts.insert(UserPost(id: id,
//                                          body: body,
//                                          image: image,
//                                          postLikes: postLikes,
//                                          postComments: postComments), at: 0)
//            }
//            
//            completion(.success(userPosts))
//        } withCancel: { error in
//            completion(.failure(.unknownError))
//        }
//    }
//    
//    func removeUserPostFromFavourite(favouritePostID: String) {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//
//        ref = Database.database(url: "https://social-network-ea509-default-rtdb.firebaseio.com/").reference()
//            .child("userStorage")
//            .child("user")
//            .child(uid)
//            .child("favouritePosts")
//            .child(favouritePostID)
//        
//        ref.removeValue()
//    }
//    
//    func removeAllUserPostFromFavourite() {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//
//        ref = Database.database(url: "https://social-network-ea509-default-rtdb.firebaseio.com/").reference()
//            .child("userStorage")
//            .child("user")
//            .child(uid)
//            .child("favouritePosts")
//        
//        ref.removeValue()
//    }
//}
//
//private extension UserFavouritePostsServiceImpl {
//    func likesArray(from likes: [Like]?) -> [[String: Any]] {
//        guard let likes = likes else {
//            return []
//        }
//        
//        return likes.map { like in
//            return [
//                "id": like.id,
//                "likedUserID": like.likedUserID ?? "",
//                "isLiked": like.isLiked ?? false
//            ]
//        }
//    }
//    
//    func commentsArray(from comments: [Comment]?) -> [[String: Any]] {
//        guard let comments = comments else {
//            return []
//        }
//        
//        return comments.map { comment in
//            return [
//                "id": comment.id ?? "",
//                "userCommentedID": comment.userCommentedID ?? "",
//                "userPhoto": comment.userPhoto ?? "",
//                "userFullname": comment.userFullname ?? "",
//                "text": comment.text ?? "",
//                "date": comment.date ?? "",
//                "likes": comment.likes ?? 0
//            ]
//        }
//    }
//}
