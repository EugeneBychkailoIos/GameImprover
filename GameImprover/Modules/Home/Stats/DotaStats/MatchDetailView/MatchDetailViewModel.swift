//
//  MatchDetailViewModel.swift
//  GameImprover
//
//  Created by jekster on 09.12.2024.
//

import Foundation
import Combine
import SwiftUI

class MatchDetailViewModel: ObservableObject {
    private var imageService = ImageService()
    
    @Published var loadedheroImages: [Int: Image] = [:]
    @Published var loadedHeroNames: [Int: String] = [:]
    
    
    @MainActor
    func getHeroImage(heroID: Int) async {
        do {
            let (documentID, imageURL) = try await FirebaseFirestoreHelper.shared.getHeroImageURLByID(heroID: heroID)
            
        } catch {
            print("Failed to fetch image data for Hero ID \(heroID): \(error.localizedDescription)")
        }
    }
    
    
}
