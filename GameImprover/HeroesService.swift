//
//  HeroesService.swift
//  GameImprover
//
//  Created by jekster on 10.12.2024.
//

import UIKit
import SwiftUI
import Combine
import FirebaseFirestore
import FirebaseAuth

class HeroesService: ObservableObject {
    @Published var images: [Int: (image: Image, heroName: String, imageURL: String)] = [:]
    
    let cacheDir: URL
    private var allHeroImages: [(id: Int, imageURL: String, documentName: String)] = []

    init() {
        self.cacheDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }

    func loadAllHeroImages() async {
        do {
            let heroImages = try await getAllHeroImagesFromFirebase()
            self.allHeroImages = heroImages
            
            for hero in heroImages {
                await downloadHeroData(heroID: hero.id)
            }
        } catch {
            print("Error loading hero images: \(error)")
        }
    }

    private func getAllHeroImagesFromFirebase() async throws -> [(id: Int, imageURL: String, documentName: String)] {
        guard let user = Auth.auth().currentUser else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User is not authenticated."])
        }
        
        let snapshot = try await Firestore.firestore().collection("HeroImages").getDocuments()
        
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
    
    func downloadHeroData(heroID: Int) async {
        do {
            let heroData = try await getHeroDataFromFirebase(heroID: heroID)
            await loadImageFromURL(heroID: heroID, imageURL: heroData.imageURL, heroName: heroData.heroName)
        } catch {
            print("Error fetching hero data for heroID \(heroID): \(error)")
        }
    }

    private func getHeroDataFromFirebase(heroID: Int) async throws -> (imageURL: String, heroName: String) {
        let snapshot = try await Firestore.firestore().collection("HeroImages").whereField("id", isEqualTo: heroID).getDocuments()
        
        guard let document = snapshot.documents.first else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Hero not found for ID \(heroID)."])
        }
        
        if let imageURL = document.get("image") as? String {
            let heroName = document.documentID.replacingOccurrences(of: "_", with: " ")
            return (imageURL, heroName)
        } else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Missing data for hero \(heroID)."])
        }
    }
    
    private func loadImageFromURL(heroID: Int, imageURL: String, heroName: String) async {
        do {
            guard let url = URL(string: imageURL) else {
                print("Invalid URL for hero \(heroName): \(imageURL)")
                return
            }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let uiImage = UIImage(data: data) {
                let heroImage = Image(uiImage: uiImage)
                
                DispatchQueue.main.async {
                    self.images[heroID] = (image: heroImage, heroName: heroName, imageURL: imageURL)
                }
                print("Downloaded image for hero \(heroName)")
            } else {
                print("Failed to create UIImage from data for hero \(heroName)")
            }
        } catch {
            print("Error downloading image for hero \(heroName): \(error)")
        }
    }

    func getHeroData(for heroID: Int) -> (image: Image, heroName: String, imageURL: String)? {
        return images[heroID]
    }

    func getAllHeroes() -> [(image: Image, heroName: String, imageURL: String)] {
        return images.values.map { ($0.image, $0.heroName, $0.imageURL) }
    }
}
