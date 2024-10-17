//
//  Endpoints.swift
//  GameImprover
//
//  Created by jekster on 17.10.2024.
//

import Foundation

enum Endpoints {
    var pass: String {
        switch self {
        case.getFriendLits:
            return "/GetFriendList/v0001/?"
        case.getUserStatsForGame:
            return "GetUserStatsForGame/v0002/?"
        case.getOwnedGames:
            return "GetOwnedGames/v0001/?"
        case.getPlayerSummaries(let key, let id):
            return "GetPlayerSummaries/v0002/?key=" + key + "&steamids=" + id
       
        }
    }
    case getFriendLits
    case getUserStatsForGame
    case getOwnedGames
    case getPlayerSummaries(String, String)
}
