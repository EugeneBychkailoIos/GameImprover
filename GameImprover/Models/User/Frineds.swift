//
//  Frineds.swift
//  GameImprover
//
//  Created by jekster on 18.10.2024.
//

import Foundation

// MARK: - Welcome
struct Friends: Codable {
    let friendslist: Friendslist
}

// MARK: - Friendslist
struct Friendslist: Codable {
    let friends: [Friend]
}

// MARK: - Friend
struct Friend: Codable {
    let steamid: String
    let relationship: Relationship
    let friendSince: Int

    enum CodingKeys: String, CodingKey {
        case steamid, relationship
        case friendSince = "friend_since"
    }
}

enum Relationship: String, Codable {
    case friend = "friend"
}

