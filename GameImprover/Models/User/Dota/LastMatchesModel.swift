//
//  LastMatchesModel.swift
//  GameImprover
//
//  Created by jekster on 28.10.2024.
//

import Foundation

// MARK: - Welcome
struct LastMatchesModel: Codable {
    let result: LastMatchesResult
}

// MARK: - Result
struct LastMatchesResult: Codable {
    let status, numResults, totalResults, resultsRemaining: Int
    let matches: [LastMatch]

    enum CodingKeys: String, CodingKey {
        case status
        case numResults = "num_results"
        case totalResults = "total_results"
        case resultsRemaining = "results_remaining"
        case matches
    }
}

// MARK: - Match
struct LastMatch: Codable {
    let matchID, matchSeqNum, startTime, lobbyType: Int
    let radiantTeamID, direTeamID: Int
    let players: [LastPlayer]

    enum CodingKeys: String, CodingKey {
        case matchID = "match_id"
        case matchSeqNum = "match_seq_num"
        case startTime = "start_time"
        case lobbyType = "lobby_type"
        case radiantTeamID = "radiant_team_id"
        case direTeamID = "dire_team_id"
        case players
    }
}

// MARK: - Player
struct LastPlayer: Codable {
    let accountID, playerSlot, teamNumber, teamSlot: Int
    let heroID, heroVariant: Int

    enum CodingKeys: String, CodingKey {
        case accountID = "account_id"
        case playerSlot = "player_slot"
        case teamNumber = "team_number"
        case teamSlot = "team_slot"
        case heroID = "hero_id"
        case heroVariant = "hero_variant"
    }
}
