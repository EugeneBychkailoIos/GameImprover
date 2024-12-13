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
    let createdAt: Timestamp
    let email: String
    let steamId: String
}
