//
//  Games.swift
//  GameImprover
//
//  Created by jekster on 14.10.2024.
//

import Foundation


// MARK: - Response
struct Response: Codable {
    let gameCount: Int
    let games: [Game]

    enum CodingKeys: String, CodingKey {
        case gameCount = "game_count"
        case games
    }
}

// MARK: - Game
struct Game: Codable {
    let appid: Int
    let playtime2Weeks: Int?
    let playtimeForever, playtimeWindowsForever, playtimeMACForever, playtimeLinuxForever: Int
    let playtimeDeckForever, rtimeLastPlayed, playtimeDisconnected: Int

    enum CodingKeys: String, CodingKey {
        case appid
        case playtime2Weeks = "playtime_2weeks"
        case playtimeForever = "playtime_forever"
        case playtimeWindowsForever = "playtime_windows_forever"
        case playtimeMACForever = "playtime_mac_forever"
        case playtimeLinuxForever = "playtime_linux_forever"
        case playtimeDeckForever = "playtime_deck_forever"
        case rtimeLastPlayed = "rtime_last_played"
        case playtimeDisconnected = "playtime_disconnected"
    }
}
