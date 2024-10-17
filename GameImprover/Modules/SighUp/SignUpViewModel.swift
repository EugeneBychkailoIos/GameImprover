//
//  SignUpViewModel.swift
//  GameImprover
//
//  Created by jekster on 10.10.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class SignUpViewModel: ObservableObject {
    
    func validateInputs(email: String, password: String, confirmPassword: String) -> Bool {
        guard !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else { return false }
        return password == confirmPassword
    }
    
    func createUser(email: String, password: String, steamId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let uid = authResult?.user.uid else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to get user ID."])))
                return
            }
            
            let userData = [
                "email": email,
                "steamId": steamId,
                "createdAt": Timestamp(date: Date())
            ]
            
            FirebaseFirestoreHelper.shared.addDocument(toCollection: "users", data: userData) { result in
                switch result {
                case .success:
                    print("Document added successfully")
                case .failure(let error):
                    print("Failed to add document: \(error.localizedDescription)")
                }
            }
            
        }
    }
}



