//
//  SignInViewModel.swift
//  GameImprover
//
//  Created by jekster on 08.10.2024.
//

import Foundation


import Foundation
import FirebaseAuth

class SignInViewModel: ObservableObject {
    @Published var errorMessage: String? = nil

    func signIn(email: String,
                password: String,
                completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }
    }
}
