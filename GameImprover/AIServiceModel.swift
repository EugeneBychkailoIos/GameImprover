//
//  AIServiceModel.swift
//  GameImprover
//
//  Created by jekster on 31.01.2025.
//

import Foundation

struct AIMatchModel: Codable {
    
    let match_id: Int
    let start_time: Int
    let player_slot: Int
    let radiant_win: Bool
}

struct AIMatchStats: Codable {
    let match_id: Int
    let players: [Player]

    struct Player: Codable {
        let account_id: Int?
        let hero_id: Int
        let kills: Int
        let deaths: Int
        let assists: Int
        let total_gold: Int
        let total_xp: Int
        let hero_damage: Int
        let tower_damage: Int
        let last_hits: Int
        let denies: Int
        let items: [Int]
    }
}
