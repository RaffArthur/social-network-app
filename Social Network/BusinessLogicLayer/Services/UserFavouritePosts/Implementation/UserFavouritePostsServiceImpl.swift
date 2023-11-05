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

//final class UserFavouritePostsServiceImpl: UserFavouritePostsService {
//    private var ref = Database.database().reference()
//
//    func addUserPostToFavourite(userID: String,
//                                postID: String,
//                                completion: @escaping SaveToFavouriteUserPostResult) {
//        ref = Database.database(url: "https://social-network-ea509-default-rtdb.firebaseio.com/").reference().child("userStorage")
//        
//        ref.child("user").child(userID).child("posts").child(postID).observeSingleEvent(of: .value) { snapshot in
//            let values = snapshot.value as? NSDictionary
//            
//            var userPosts = [UserPost]()
//            
//            values?.forEach { key, value in
//                let value = value as? NSDictionary
//                let key = key as? String
//                
//                if postID == key {
//                    let body = value?["body"] as? String ?? ""
//                    let images = value?["images"] as? [String] ?? [""]
//                    let likeCount = value?["likeCount"] as? Int ?? 0
//                    let commentCount = value?["commentCount"] as? Int ?? 0
//                    
//                    userPosts.insert(UserPost(body: body,
//                                              images: images,
//                                              likeCount: likeCount,
//                                              commentCount: commentCount), at: 0)
//                } else {
//                    completion(.failure(.unknownError))
//                }
//                
//                completion(.success(userPosts))
//            }
//        } withCancel: { error in
//            completion(.failure(.unknownError))
//        }
//    }
//    
//    func removeFromFavourite(userPost: UserPost) {
//        
//    }
//    
//    func removeAllFavouritePosts() {
//        
//    }
//}
