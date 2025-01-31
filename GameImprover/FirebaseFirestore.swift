//
//  FirebaseFirestore.swift
//  GameImprover
//
//  Created by jekster on 10.10.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreCombineSwift
import FirebaseAuth

class FirebaseFirestoreHelper {
    
    private let db = Firestore.firestore()

    // MARK: - Singleton
    static let shared = FirebaseFirestoreHelper()
    private init() {}

    // MARK: - Add Data to Firestore
    
    func addDocument(toCollection collection: String, 
                     data: [String: Any],
                     documentID: String? = nil,
                     completion: @escaping (Result<Void, Error>) -> Void) {
        if let documentID = documentID {
            db.collection(collection).document(documentID).setData(data) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        } else {
            db.collection(collection).addDocument(data: data) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        }
    }
    
    func updateDocument(inCollection collection: String,
                        documentID: String,
                        data: [String: Any],
                        completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection(collection).document(documentID).updateData(data) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func deleteDocument(fromCollection collection: String,
                        documentID: String,
                        completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection(collection).document(documentID).delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    // MARK: - Fetch Data from Firestore

    func getDocuments(fromCollection collection: String, 
                      completion: @escaping (Result<[DocumentSnapshot], Error>) -> Void) {
        db.collection(collection).getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                completion(.success(snapshot.documents))
            }
        }
    }
    
    
    func getDocument(fromCollection collection: String,
                     documentID: String,
                     completion: @escaping (Result<DocumentSnapshot, Error>) -> Void) {
        db.collection(collection).document(documentID).getDocument { document, error in
            if let error = error {
                completion(.failure(error))
            } else if let document = document, document.exists {
                completion(.success(document))
            } else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Document does not exist."])))
            }
        }
    }
    

    func getHeroImageURLByID(heroID: Int) async throws -> (String, String) {
        guard Auth.auth().currentUser != nil else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User is not authenticated."])
        }

        let snapshot = try await db.collection("HeroImages")
            .whereField("id", isEqualTo: heroID)
            .getDocuments()

        guard let document = snapshot.documents.first,
              let imageURL = document.get("image") as? String else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Image URL not found in Firestore."])
        }

        let documentID = document.documentID
        return (documentID, imageURL)
    }
    
    
    func getAllHeroImages() async throws -> [(id: Int, imageURL: String, documentName: String)] {
        guard Auth.auth().currentUser != nil else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User is not authenticated."])
        }
        
        let snapshot = try await db.collection("HeroImages").getDocuments()
        
        guard !snapshot.documents.isEmpty else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No documents found in Firestore."])
        }
        
        var heroImages: [(id: Int, imageURL: String, documentName: String)] = []
        
        for document in snapshot.documents {
            if let imageURL = document.get("image") as? String,
               let heroID = document.get("id") as? Int {
                let documentName = document.documentID.replacingOccurrences(of: "_", with: " ")
                
                heroImages.append((id: heroID, imageURL: imageURL, documentName: documentName))
            }
        }
        
        return heroImages
    }
    
    
    
    func addDocuments(toCollection collection: String,
                      data: [[String: Any]],
                      completion: @escaping (Result<[Void], Error>) -> Void) {
        var results: [Void] = []
        let dispatchGroup = DispatchGroup()

        for documentData in data {
            dispatchGroup.enter()
            db.collection(collection).addDocument(data: documentData) { error in
                if let error = error {
                    completion(.failure(error))
                    dispatchGroup.leave()
                    return
                }
                results.append(())
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(.success(results))
        }
    }

    // for check is document available.
    
    func documentExists(inCollection collection: String,
                        documentID: String,
                        completion: @escaping (Bool, Error?) -> Void) {
        db.collection(collection).document(documentID).getDocument { document, error in
            if let error = error {
                completion(false, error)
            } else {
                completion(document?.exists ?? false, nil)
            }
        }
    }



}
