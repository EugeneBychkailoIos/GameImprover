//
//  DotaMatchDetailModel.swift
//  GameImprover
//
//  Created by jekster on 13.12.2024.
//

import Foundation

struct ItemDota: Codable {
    let itemId: Int
}

struct MapPlayer: Codable, Identifiable {
    var id = UUID()
    var isRadiant: Bool
    var playerNickname: String
    var heroImage: String
    var heroName: String
    var kills: Int
    var deaths: Int
    var assists: Int
    var items: [ItemDota]
    var xpm: Int
    var gpm: Int
    var lastHits: Int
    var denied: Int
    var networth: Int
    var heroId: Int
}

struct DotaMatchDetailModel: Codable {
    let players: [MapPlayer]
}
