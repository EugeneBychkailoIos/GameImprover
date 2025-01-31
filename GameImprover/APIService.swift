//
//  APIService.swift
//  GameImprover
//
//  Created by jekster on 17.10.2024.
//

import Foundation

protocol ApiServiceProtoc {
    // DOTA2
    func getUserInfo(key: String, id: String) async throws -> [Player]
    func getFrinedList(key: String, id: String) async throws -> [Friend]
    func getOwnedGames(key: String, id: String) async throws -> [Game]
    func getLastMatches(key: String, id: String, matches: Int) async throws -> [LastMatch]
    func getMatchById(key: String, matchId: String) async throws -> [MatchDetailModel]
    // CS2
    func getUserAllRecords(key: String, id: String ) async throws -> [Playerstats]
    func getLastCS2Matches(key: String, id: String, matchId: Int) async throws -> [CS2Match]
    func getCS2UserItems(id: String) async throws -> InventoryItem
}

 class Api {
    private let networkService: NetworkServiceProtocol
    fileprivate let decoder = JSONDecoder()
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    private let base = "https://api.steampowered.com/"
    private let openDotaBase = "https://api.opendota.com/api/"

}

extension Api: ApiServiceProtoc {
    func getCS2UserItems(id: String) async throws -> InventoryItem {
        guard let url = URL(string: "https://" + Endpoints.getCS2UserItems(id).pass) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let data = try await networkService.request(request: request)
        
        let items = try decoder.decode(InventoryItem.self, from: data)
        return items
    }
    
    func getLastCS2Matches(key: String, id: String, matchId: Int) async throws -> [CS2Match] {
        guard let url = URL(string: base +  Midpoints.cs2Records.pass + Endpoints.getCS2LastMatches(key, id, matchId).pass) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let data = try await networkService.request(request: request)
        
        let lastMatches = try decoder.decode(CS2MatchesResponse.self, from: data)
        return lastMatches.matches
    }
    
    func getUserAllRecords(key: String, id: String) async throws -> [Playerstats] {
        guard let url = URL(string: base +  Midpoints.cs2Records.pass + Endpoints.getCS2Records(key, id).pass) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let data = try await networkService.request(request: request)
        
        let userRecords = try decoder.decode(CS2Records.self, from: data)
        return [userRecords.playerstats]
    }
    
    
    func getUserInfo(key: String, id: String) async throws -> [Player] {
        guard let url = URL(string: base + Midpoints.steamUser.pass + Endpoints.getPlayerSummaries(key, id).pass) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let data = try await networkService.request(request: request)
        
        let userInfo = try decoder.decode(UserInfo.self, from: data)
        return userInfo.response.players
    }
    
    func getFrinedList(key: String, id: String) async throws -> [Friend] {
        guard let url = URL(string: base + Midpoints.steamUser.pass + Endpoints.getFriendList(key, id).pass) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let data = try await networkService.request(request: request)
        
        let friends = try decoder.decode(Friends.self, from: data)
        return friends.friendslist.friends
    }
    
    func getOwnedGames(key: String, id: String) async throws -> [Game] {
        guard let url = URL(string: base + Midpoints.playerService.pass + Endpoints.getOwnedGames(key, id).pass) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let data = try await networkService.request(request: request)
        
        let games = try decoder.decode(OwnedGames.self, from: data)
        return games.response.games
    }
    
    func getLastMatches(key: String, id: String, matches: Int) async throws -> [LastMatch] {
        guard let url = URL(string: base + Midpoints.dotaMain.pass + Endpoints.getLastMatches(key, id, matches).pass) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let data = try await networkService.request(request: request)
        
        let dotaMatches = try decoder.decode(LastMatchesModel.self, from: data)
        return dotaMatches.result.matches
    }
    
    func getMatchById(key: String, matchId: String) async throws -> [MatchDetailModel] {
        guard let url = URL(string: openDotaBase + Endpoints.openDotaMatchById(matchId, key).pass) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let data = try await networkService.request(request: request)
        
        let match = try decoder.decode(MatchDetailModel.self, from: data)
        return [match]
    }
}
