//
//  Firestore.swift
//  Vybz
//
//  Created by God on 12/12/19.
//  Copyright © 2019 God. All rights reserved.
//

import Foundation
import Foundation
import Firebase


fileprivate enum FireStoreCollections: String {
    case users
    case favorites
}

class FirestoreService {
    static let manager = FirestoreService()
    
    private let db = Firestore.firestore()
    
    //MARK: AppUsers
    func createAppUser(user: AppUser, completion: @escaping (Result<(), Error>) -> ()) {
        var fields = user.fieldsDict
        fields["dateCreated"] = Date()
        db.collection(FireStoreCollections.users.rawValue).document(user.uid).setData(fields) { (error) in
            if let error = error {
                completion(.failure(error))
                print(error)
            }
            completion(.success(()))
        }
    }
    
    func updateCurrentUser(userName: String? = nil, photoURL: URL? = nil, completion: @escaping (Result<(), Error>) -> ()){
        guard let userId = FirebaseAuthService.manager.currentUser?.uid else {
            //MARK: TODO - handle can't get current user
            return
        }
        var updateFields = [String:Any]()
        
        if let user = userName {
            updateFields["userName"] = user
        }
        
        if let photo = photoURL {
            updateFields["photoURL"] = photo.absoluteString
        }
        db.collection(FireStoreCollections.users.rawValue).document(userId).updateData(updateFields) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
            
        }
    }
    
    func getAllUsers(completion: @escaping (Result<[AppUser], Error>) -> ()) {
        db.collection(FireStoreCollections.users.rawValue).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                let users = snapshot?.documents.compactMap({ (snapshot) -> AppUser? in
                    let userID = snapshot.documentID
                    let user = AppUser(from: snapshot.data(), id: userID)
                    return user
                })
                completion(.success(users ?? []))
            }
        }
    }
        func addFavorite(favs: FaveMood, completion: @escaping (Result<(), Error>) -> ()) {
        db.collection(FireStoreCollections.favorites.rawValue).addDocument(data: favs.fieldsDict) { (error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        }

        func getFavs(forUserID: String, completion: @escaping (Result<[FaveMood], Error>) -> ()) {
            db.collection(FireStoreCollections.favorites.rawValue).whereField("uid", isEqualTo: forUserID).getDocuments { (snapshot, error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    let favs = snapshot?.documents.compactMap({ (snapshot) -> FaveMood? in
                        let favID = snapshot.documentID
                        print(favID)
                        let fav = FaveMood(from: snapshot.data(), id: favID)
                        return fav
                    })
                    completion(.success(favs ?? []))
                }
            }

        }


    
    
    }
    
