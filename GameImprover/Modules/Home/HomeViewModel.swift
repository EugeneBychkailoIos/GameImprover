//
//  HomeViewModel.swift
//  GameImprover
//
//  Created by jekster on 11.10.2024.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var gamesArray: [String] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let key: String = "12D2701F45A45E9E773F2293FCCA5685"
    private let id: String = "76561199562083135"

    let gameTitles: [Int: String] = [
        730: "Counter-Strike: Global Offensive",
        570: "Dota 2"
    ]
    
    var userNickName: String = ""
    var userAvatarString: String = ""
    
    @MainActor
    func loadUserData() async {
        isLoading = true
        
        do {
            try await getUserInfo()
            try await getOwnedGames()
        } catch {
            self.errorMessage = error.localizedDescription
            self.isLoading = false
        }
        
        self.isLoading = false
    }
    
    @MainActor
    func processOwnedGames(_ games: [Game]) -> [String] {
        return games.compactMap { game in
            gameTitles[game.appid]
        }
    }

    @MainActor
    private func getOwnedGames() async throws {
        do {
            let games = try await ServiceContainer.shared.apiService.getOwnedGames(key: key, id: id)
            self.gamesArray = self.processOwnedGames(games)
        } catch {
            self.errorMessage = error.localizedDescription
            throw error
        }
    }

    @MainActor
    private func getUserInfo() async throws {
        do {
            let userInfo = try await ServiceContainer.shared.apiService.getUserInfo(key: key, id: id)
            
            if let firstUser = userInfo.first {
                self.userNickName = firstUser.personaname
                self.userAvatarString = firstUser.avatarfull
            }
        } catch {
            self.errorMessage = error.localizedDescription
            throw error
        }
    }
}
