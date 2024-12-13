//
//  MatchDetailModel.swift
//  GameImprover
//
//  Created by jekster on 04.12.2024.
//

import Foundation

// MARK: - MatchDetailModel
struct MatchDetailModel: Codable {
    let players: [MatchDetailPlayer]
    let radiantWin: Bool
    let duration, preGameDuration, startTime, matchID: Int
    let matchSeqNum, towerStatusRadiant, towerStatusDire, barracksStatusRadiant: Int
    let barracksStatusDire, cluster, firstBloodTime, lobbyType: Int
    let humanPlayers, leagueid, gameMode, flags: Int
    let engine, radiantScore, direScore: Int
    let picksBans: [PicksBan]
    let odData: OdData
    let metadata: JSONNull?
    let patch, region: Int

    enum CodingKeys: String, CodingKey {
        case players
        case radiantWin = "radiant_win"
        case duration
        case preGameDuration = "pre_game_duration"
        case startTime = "start_time"
        case matchID = "match_id"
        case matchSeqNum = "match_seq_num"
        case towerStatusRadiant = "tower_status_radiant"
        case towerStatusDire = "tower_status_dire"
        case barracksStatusRadiant = "barracks_status_radiant"
        case barracksStatusDire = "barracks_status_dire"
        case cluster
        case firstBloodTime = "first_blood_time"
        case lobbyType = "lobby_type"
        case humanPlayers = "human_players"
        case leagueid
        case gameMode = "game_mode"
        case flags, engine
        case radiantScore = "radiant_score"
        case direScore = "dire_score"
        case picksBans = "picks_bans"
        case odData = "od_data"
        case metadata, patch, region
    }
}

// MARK: - OdData
struct OdData: Codable {
    let hasAPI, hasGcdata, hasParsed, hasArchive: Bool

    enum CodingKeys: String, CodingKey {
        case hasAPI = "has_api"
        case hasGcdata = "has_gcdata"
        case hasParsed = "has_parsed"
        case hasArchive = "has_archive"
    }
}

// MARK: - PicksBan
struct PicksBan: Codable {
    let isPick: Bool
    let heroID, team, order: Int

    enum CodingKeys: String, CodingKey {
        case isPick = "is_pick"
        case heroID = "hero_id"
        case team, order
    }
}

// MARK: - Player
struct MatchDetailPlayer: Codable {
    let playerSlot, teamNumber, teamSlot, heroID: Int
    let heroVariant, item0, item1, item2: Int
    let item3, item4, item5, backpack0: Int
    let backpack1, backpack2, itemNeutral, kills: Int
    let deaths, assists, leaverStatus, lastHits: Int
    let denies, goldPerMin, xpPerMin, level: Int
    let netWorth, aghanimsScepter, aghanimsShard, moonshard: Int
    let heroDamage, towerDamage, heroHealing, gold: Int
    let goldSpent: Int
    let abilityUpgradesArr: [Int]
    let radiantWin: Bool
    let startTime, duration, cluster, lobbyType: Int
    let gameMode: Int
    let isContributor: Bool
    let patch, region: Int
    let isRadiant: Bool
    let win, lose, totalGold, totalXP: Int
    let killsPerMin: Double?
    let kda: Double
    let abandons: Int
    let rankTier: Int?
    let isSubscriber: Bool
    let benchmarks: Benchmarks
    let accountID: Int?
    let personaname: String?
    let name: JSONNull?
    let lastLogin: String?

    enum CodingKeys: String, CodingKey {
        case playerSlot = "player_slot"
        case teamNumber = "team_number"
        case teamSlot = "team_slot"
        case heroID = "hero_id"
        case heroVariant = "hero_variant"
        case item0 = "item_0"
        case item1 = "item_1"
        case item2 = "item_2"
        case item3 = "item_3"
        case item4 = "item_4"
        case item5 = "item_5"
        case backpack0 = "backpack_0"
        case backpack1 = "backpack_1"
        case backpack2 = "backpack_2"
        case itemNeutral = "item_neutral"
        case kills, deaths, assists
        case leaverStatus = "leaver_status"
        case lastHits = "last_hits"
        case denies
        case goldPerMin = "gold_per_min"
        case xpPerMin = "xp_per_min"
        case level
        case netWorth = "net_worth"
        case aghanimsScepter = "aghanims_scepter"
        case aghanimsShard = "aghanims_shard"
        case moonshard
        case heroDamage = "hero_damage"
        case towerDamage = "tower_damage"
        case heroHealing = "hero_healing"
        case gold
        case goldSpent = "gold_spent"
        case abilityUpgradesArr = "ability_upgrades_arr"
        case radiantWin = "radiant_win"
        case startTime = "start_time"
        case duration, cluster
        case lobbyType = "lobby_type"
        case gameMode = "game_mode"
        case isContributor = "is_contributor"
        case patch, region, isRadiant, win, lose
        case totalGold = "total_gold"
        case totalXP = "total_xp"
        case killsPerMin = "kills_per_min"
        case kda, abandons
        case rankTier = "rank_tier"
        case isSubscriber = "is_subscriber"
        case benchmarks
        case accountID = "account_id"
        case personaname, name
        case lastLogin = "last_login"
    }
}

// MARK: - Benchmarks
struct Benchmarks: Codable {
    let goldPerMin, xpPerMin, killsPerMin, lastHitsPerMin: [String: Double]
    let heroDamagePerMin, heroHealingPerMin, towerDamage: [String: Double]

    enum CodingKeys: String, CodingKey {
        case goldPerMin = "gold_per_min"
        case xpPerMin = "xp_per_min"
        case killsPerMin = "kills_per_min"
        case lastHitsPerMin = "last_hits_per_min"
        case heroDamagePerMin = "hero_damage_per_min"
        case heroHealingPerMin = "hero_healing_per_min"
        case towerDamage = "tower_damage"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}
