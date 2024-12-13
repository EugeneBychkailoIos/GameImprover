//
//  UserService.swift
//  GameImprover
//
//  Created by jekster on 21.10.2024.
//

import Foundation
import FirebaseFirestore

class UserService {
    let db = Firestore.firestore()

    func getUser(withID userID: String, completion: @escaping (User?, Error?) -> Void) {
        let userDocRef = db.collection("users").document(userID)

        userDocRef.getDocument { (document, error) in
            if let error = error {
                completion(nil, error)
            } else if let document = document, document.exists {
                do {
                    let user = try document.data(as: User.self)
                    completion(user, nil)
                } catch {
                    completion(nil, error)
                }
            } else {
                completion(nil, nil)
            }
        }
    }

        func getUserByEmail(email: String, completion: @escaping (User?, Error?) -> Void) {
            db.collection("users").whereField("email", isEqualTo: email).getDocuments { (querySnapshot, error) in
                if let error = error {
                    completion(nil, error)
                } else if let documents = querySnapshot?.documents, !documents.isEmpty {
                    do {
                        let user = try documents.first?.data(as: User.self)
                        completion(user, nil)
                    } catch {
                        completion(nil, error)
                    }
                } else {
                    completion(nil, nil)
                }
            }
        }

        func getUserBySteamId(steamId: String, completion: @escaping (User?, Error?) -> Void) {
            db.collection("users").whereField("steamId", isEqualTo: steamId).getDocuments { (querySnapshot, error) in
                if let error = error {
                    completion(nil, error)
                } else if let documents = querySnapshot?.documents, !documents.isEmpty {
                    do {
                        let user = try documents.first?.data(as: User.self)
                        completion(user, nil)
                    } catch {
                        completion(nil, error)
                    }
                } else {
                    completion(nil, nil)
            }
        }
    }
}
