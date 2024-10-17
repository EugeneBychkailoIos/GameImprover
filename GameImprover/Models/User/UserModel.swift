//
//  UserModel.swift
//  GameImprover
//
//  Created by jekster on 09.10.2024.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreCombineSwift

struct User: Codable, Identifiable {
    @DocumentID var id: String?
    
    let email: String
    let password: String
    let steamiD: String
}
