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
        case.getFriendList(let key, let id):
            return "GetFriendList/v0001/?key=" + key + "&steamid=" + id + "&relationship=friend"
        case.getUserStatsForGame:
            return "GetUserStatsForGame/v0002/?"
        case.getOwnedGames(let key, let id):
            return "GetOwnedGames/v0001/?key=" + key + "&steamid=" + id + "&format=json&skip_unvetted_apps=false&include_played_free_games=1"
        case.getPlayerSummaries(let key, let id):
            return "GetPlayerSummaries/v0002/?key=" + key + "&steamids=" + id
        case.getDotaMatchHistory(let key, let id):
            return "GetMatchHistoryBySequenceNum/v1/?key=" + key + "&steamid=" + id
        case.getLastMatches(let key, let id, let matches):
            return "GetMatchHistory/v1/?key=" + key + "&account_id=" + id + "&matches_requested=" + "\(matches)"
        case.openDotaMatchById(let matchId, let key):
            return "matches/\(matchId)?api_key=\(key)"
        case .getCS2Records(let key, let id):
            return "/v2/?appid=730&key=" + key + "&steamid=" + id
        case .getCS2LastMatches(let key, let id, let matchId):
            return "GetMatchHistory/v1/?key=" + key + "&account_id=" + id + "&matches_requested=" + "\(matchId)"
        case .getCS2UserItems(let id):
            return "steamcommunity.com/inventory/" + id + "/730/2"
        }
    }
    case getFriendList(String, String)
    case getUserStatsForGame
    case getOwnedGames(String, String)
    case getPlayerSummaries(String, String)
    case getDotaMatchHistory(String,String)
    case getLastMatches(String, String, Int)
    case openDotaMatchById(String, String)
    case getCS2Records(String, String)
    case getCS2LastMatches(String, String, Int)
    case getCS2UserItems(String)
}
