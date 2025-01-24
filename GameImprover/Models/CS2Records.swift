//
//  CS2Records.swift
//  GameImprover
//
//  Created by jekster on 24.01.2025.
//

import Foundation

struct CS2Records: Codable {
    let playerstats: Playerstats
}

// MARK: - Playerstats
struct Playerstats: Codable {
    let steamID, gameName: String
    let stats: [Stat]
    let achievements: [Achievement]
}

// MARK: - Achievement
struct Achievement: Codable {
    let name: String
    let achieved: Int
}

// MARK: - Stat
struct Stat: Codable {
    let name: String
    let value: Int
}
