//
//  UserDataServiceImpl.swift
//  Social_Network
//
//  Created by Arthur Raff on 16.10.2023.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseDatabase

final class UserDataServiceImpl: UserDataService {    
    private var ref = Database.database().reference()
    
    func getUsers(completion: @escaping GetUsersResult) {
        ref = Database.database(url: "https://social-network-ea509-default-rtdb.firebaseio.com/").reference().child("userStorage")
        
        ref.child("user").observeSingleEvent(of: .value) { snapshot in
            let value = snapshot.value as? NSDictionary
            
            var users = Users(user: [:])
            
            value?.forEach { userID, user in
                let user = user as? NSDictionary
                guard let userID = userID as? String else { return }
                
                let uid = value?["userID"] as? String ?? ""
                let name = value?["name"] as? String ?? ""
                let surname = value?["surname"] as? String ?? ""
                let nickname = value?["nickname"] as? String ?? ""
                let birthDate = value?["birthDate"] as? String ?? ""
                let gender = value?["gender"] as? String ?? ""
                let regalia = value?["regalia"] as? String ?? ""
                let hometown = value?["hometown"] as? String ?? ""
                
                let userData = UserData(userID: uid,
                                        name: name,
                                        surname: surname,
                                        nickname: nickname,
                                        regalia: regalia,
                                        hometown: hometown,
                                        birthDate: birthDate,
                                        gender: gender,
                                        isGenderSelected: nil)
                
                users.user?.updateValue(userData, forKey: userID)
            }
            
            completion(.success(users))
        } withCancel: { error in
            completion(.failure(.unknownError))
        }

    }
    
    func getUserData(completion: @escaping GetUserDataResult) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ref = Database.database(url: "https://social-network-ea509-default-rtdb.firebaseio.com/").reference().child("userStorage")
        
        ref.child("user").child(uid).observeSingleEvent(of: .value) { snapshot in
            let value = snapshot.value as? NSDictionary
            
            let uid = value?["userID"] as? String ?? ""
            let name = value?["name"] as? String ?? ""
            let surname = value?["surname"] as? String ?? ""
            let nickname = value?["nickname"] as? String ?? ""
            let birthDate = value?["birthDate"] as? String ?? ""
            let gender = value?["gender"] as? String ?? ""
            let regalia = value?["regalia"] as? String ?? ""
            let hometown = value?["hometown"] as? String ?? ""
            
            let userData = UserData(userID: uid,
                                    name: name,
                                    surname: surname,
                                    nickname: nickname,
                                    regalia: regalia,
                                    hometown: hometown,
                                    birthDate: birthDate,
                                    gender: gender,
                                    isGenderSelected: nil)
            
            completion(.success(userData))
        } withCancel: { error in
            completion(.failure(.unknownError))
        }
    }
    
    func saveUserData(userData: UserData, completion: @escaping SaveUserDataResult) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        ref = Database.database(url: "https://social-network-ea509-default-rtdb.firebaseio.com/").reference().child("userStorage")
        
        guard let name = userData.name,
              let surname = userData.surname,
              let nickname = userData.nickname,
              let birthDate = userData.birthDate,
              let gender = userData.gender,
              let regalia = userData.regalia,
              let hometown = userData.hometown,
              let isGenderSelected = userData.isGenderSelected
        else {
            return
        }
        
        let inputDataValidationError = userMainProfileInfoValidation(name: name,
                                                                     surname: surname,
                                                                     birthDate: birthDate,
                                                                     regalia: regalia,
                                                                     hometown: hometown,
                                                                     isGenderSelected: isGenderSelected)
        
        guard inputDataValidationError == nil else {
            inputDataValidationError.flatMap { completion(.failure($0))}
            
            return
        }
        
        // Не понял, как здесь обработать ошибку
        ref.child("user").child(uid).setValue(["userID": uid,
                                               "name": name,
                                               "surname": surname,
                                               "nickname": nickname,
                                               "birthDate": birthDate,
                                               "gender": gender,
                                               "regalia": regalia,
                                               "hometown": hometown])
            
        completion(.success(userData))
    }
}

private extension UserDataServiceImpl {
    func userMainProfileInfoValidation(name: String,
                                       surname: String,
                                       birthDate: String,
                                       regalia: String,
                                       hometown: String,
                                       isGenderSelected: Bool) -> UserMainProfileInfoError? {
        if name.isEmpty || surname.isEmpty || birthDate.isEmpty || isGenderSelected == false || regalia.isEmpty || hometown.isEmpty {
            return .emptyFields
        }
        
        return nil
    }
}
