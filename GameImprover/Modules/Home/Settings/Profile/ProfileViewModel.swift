//
//  ProfileViewModel.swift
//  GameImprover
//
//  Created by jekster on 24.01.2025.
//

import Foundation


class ProfileViewModel: ObservableObject {
    
    private let key: String = "12D2701F45A45E9E773F2293FCCA5685"
    private let id: String = "76561199562083135"
    
    var userNickName: String = ""
    var userAvatarString: String = ""
    var lastLogoff: Int = 0
    var personState: Int = 0
    var profileState: Int = 0
    var profileUrl: String = ""
    var steamId: String = ""
    var timeCreated: Int = 0
    
    @Published var errorMessage: String?
    
    @MainActor
    func getUserInfo() async throws {
        do {
            let userInfo = try await ServiceContainer.shared.apiService.getUserInfo(key: key, id: id)
            
            if let firstUser = userInfo.first {
                self.userNickName = firstUser.personaname
                self.userAvatarString = firstUser.avatarfull
                self.lastLogoff = firstUser.lastlogoff
                self.personState = firstUser.personastate
                self.profileState = firstUser.profilestate
                self.profileUrl = firstUser.profileurl
                self.steamId = firstUser.steamid
                self.timeCreated = firstUser.timecreated
            }
        } catch {
            self.errorMessage = error.localizedDescription
            throw error
        }
    }
    
    // TO:DO - add variables to profile for compare user stats in different games.
    
    func compareGameTimeAndSuccess(dotaPlaytime: Double, csPlaytime: Double, dotaKDR: Double, csKDR: Double, dotaWinRate: Double, csWinRate: Double) -> String {
        
        let dotaTimeMessage = "Dota 2: \(dotaPlaytime) hours"
        let csTimeMessage = "CS:GO: \(csPlaytime) hours"
        
        var gameWithMoreTime = ""
        if dotaPlaytime > csPlaytime {
            gameWithMoreTime = "Dota 2"
        } else if csPlaytime > dotaPlaytime {
            gameWithMoreTime = "CS:GO"
        } else {
            gameWithMoreTime = "Both games"
        }
    
        var betterGame = ""
        if dotaKDR > csKDR {
            betterGame = "Dota 2"
        } else if csKDR > dotaKDR {
            betterGame = "CS:GO"
        } else {
            betterGame = "Both games"
        }
        
        var betterWinRateGame = ""
        if dotaWinRate > csWinRate {
            betterWinRateGame = "Dota 2"
        } else if csWinRate > dotaWinRate {
            betterWinRateGame = "CS:GO"
        } else {
            betterWinRateGame = "Both games"
        }
        
        // here i need add result in what game user spend more time, and compare winrates and his progress. (should add ai. )
        
        let result = ""
   
        return result
    }

}
