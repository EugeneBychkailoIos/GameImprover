//
//  Midpoints.swift
//  GameImprover
//
//  Created by jekster on 17.10.2024.
//

import Foundation

enum Midpoints {
    var pass: String {
        switch self {
        case.dotaMain:
            return "/IDOTA2Match_570"
        case.steamUser:
            return "ISteamUser/"
        case.playerService:
            return "/IPlayerService"
        case.steamUserStats:
            return "/ISteamUserStats/"
        }
    }
    
    case dotaMain
    case steamUser
    case playerService
    case steamUserStats
}
