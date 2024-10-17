//
//  UserInfo.swift
//  GameImprover
//
//  Created by jekster on 17.10.2024.
//

import Foundation

// MARK: - UserInfo
struct UserInfo: Decodable {
    let response: UserResponse
}

// MARK: - UserResponse
struct UserResponse: Decodable {
    let players: [Player]
}

// MARK: - Player
struct Player: Codable {
    let steamid: String
    let communityvisibilitystate, profilestate: Int
    let personaname: String
    let profileurl: String
    let avatar, avatarmedium, avatarfull: String
    let avatarhash: String
    let lastlogoff, personastate: Int
    let primaryclanid: String
    let timecreated, personastateflags: Int
}
