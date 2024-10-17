//
//  FirebaseFirestore.swift
//  GameImprover
//
//  Created by jekster on 10.10.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreCombineSwift

class FirebaseFirestoreHelper {
    
    private let db = Firestore.firestore()

    // MARK: - Singleton
    static let shared = FirebaseFirestoreHelper()
    private init() {}

    // MARK: - Add Data to Firestore
    
    /// Додає документ з даними до конкретної колекції
    /// - Parameters:
    ///   - collection: Ім'я колекції
    ///   - data: Дані для збереження
    ///   - documentID: (Необов'язковий) Ідентифікатор документа, якщо його потрібно задати
    ///   - completion: Блок завершення з результатом
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
    
    /// Оновлює документ у конкретній колекції
    /// - Parameters:
    ///   - collection: Ім'я колекції
    ///   - documentID: Ідентифікатор документа
    ///   - data: Дані для оновлення
    ///   - completion: Блок завершення з результатом
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
    
    /// Видаляє документ з колекції
    /// - Parameters:
    ///   - collection: Ім'я колекції
    ///   - documentID: Ідентифікатор документа для видалення
    ///   - completion: Блок завершення з результатом
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
    
    /// Отримує всі документи з конкретної колекції
    /// - Parameters:
    ///   - collection: Ім'я колекції
    ///   - completion: Блок завершення з результатом
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
    
    /// Отримує один документ за ID
    /// - Parameters:
    ///   - collection: Ім'я колекції
    ///   - documentID: Ідентифікатор документа
    ///   - completion: Блок завершення з результатом
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
}
