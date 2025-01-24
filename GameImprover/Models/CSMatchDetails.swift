//
//  CSMatchDetails.swift
//  GameImprover
//
//  Created by jekster on 28.10.2024.
//

import Foundation


struct CS2MatchesResponse: Codable {
    var matches: [CS2Match]
}

struct CS2PlayerStats: Codable {
    var kills: Int
    var deaths: Int
    var assists: Int
    var damage: Int
    var headshots: Int
    var accuracy: Double
    var score: Int
    var mvps: Int
    var roundsWon: Int
    var roundsLost: Int
}

struct CS2Match: Codable {
    var matchId: String
    var matchDate: Date
    var mapName: String
    var result: String
    

    var alliesStats: [CS2PlayerStats]
    var enemiesStats: [CS2PlayerStats]
    var playerStats: CS2PlayerStats
}
