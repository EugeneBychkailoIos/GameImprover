//
//  DotaMatchDetails.swift
//  GameImprover
//
//  Created by jekster on 28.10.2024.
//

//import Foundation
//
//// MARK: - Welcome
//struct DotaMatchDetailsResponse: Codable {
//    let result: DotaMatchDetails
//}
//
//// MARK: - Result
//struct DotaMatchDetails: Codable {
//    let status: Int
//    let matches: [MatchDetail]
//}
//
//// MARK: - Match
//struct MatchDetail: Codable {
//    let players: [DotaPlayer]
//    let radiantWin: Bool
//    let duration, preGameDuration, startTime, matchID: Int
//    let matchSeqNum, towerStatusRadiant, towerStatusDire, barracksStatusRadiant: Int
//    let barracksStatusDire, cluster, firstBloodTime, lobbyType: Int
//    let humanPlayers, leagueid, gameMode, flags: Int
//    let engine, radiantScore, direScore: Int
//    let picksBans: [PicksBan]?
//
//    enum CodingKeys: String, CodingKey {
//        case players
//        case radiantWin = "radiant_win"
//        case duration
//        case preGameDuration = "pre_game_duration"
//        case startTime = "start_time"
//        case matchID = "match_id"
//        case matchSeqNum = "match_seq_num"
//        case towerStatusRadiant = "tower_status_radiant"
//        case towerStatusDire = "tower_status_dire"
//        case barracksStatusRadiant = "barracks_status_radiant"
//        case barracksStatusDire = "barracks_status_dire"
//        case cluster
//        case firstBloodTime = "first_blood_time"
//        case lobbyType = "lobby_type"
//        case humanPlayers = "human_players"
//        case leagueid
//        case gameMode = "game_mode"
//        case flags, engine
//        case radiantScore = "radiant_score"
//        case direScore = "dire_score"
//        case picksBans = "picks_bans"
//    }
//}
//
//// MARK: - PicksBan
//struct PicksBan: Codable {
//    let isPick: Bool
//    let heroID, team, order: Int
//
//    enum CodingKeys: String, CodingKey {
//        case isPick = "is_pick"
//        case heroID = "hero_id"
//        case team, order
//    }
//}
//
//// MARK: - Player
//struct DotaPlayer: Codable {
//    let accountID: Int?
//    let playerSlot, teamNumber, teamSlot, heroID: Int
//    let heroVariant, item0, item1, item2: Int
//    let item3, item4, item5, backpack0: Int
//    let backpack1, backpack2, itemNeutral, kills: Int
//    let deaths, assists: Int
//    let leaverStatus: Int?
//    let lastHits, denies, goldPerMin, xpPerMin: Int
//    let level, netWorth: Int
//    let aghanimsScepter, aghanimsShard, moonshard: Int?
//    let heroDamage, towerDamage, heroHealing, gold: Int
//    let goldSpent, scaledHeroDamage, scaledTowerDamage, scaledHeroHealing: Int
//    let abilityUpgrades: [AbilityUpgrade]?
//    let additionalUnits: [AdditionalUnit]?
//
//    enum CodingKeys: String, CodingKey {
//        case accountID = "account_id"
//        case playerSlot = "player_slot"
//        case teamNumber = "team_number"
//        case teamSlot = "team_slot"
//        case heroID = "hero_id"
//        case heroVariant = "hero_variant"
//        case item0 = "item_0"
//        case item1 = "item_1"
//        case item2 = "item_2"
//        case item3 = "item_3"
//        case item4 = "item_4"
//        case item5 = "item_5"
//        case backpack0 = "backpack_0"
//        case backpack1 = "backpack_1"
//        case backpack2 = "backpack_2"
//        case itemNeutral = "item_neutral"
//        case kills, deaths, assists
//        case leaverStatus = "leaver_status"
//        case lastHits = "last_hits"
//        case denies
//        case goldPerMin = "gold_per_min"
//        case xpPerMin = "xp_per_min"
//        case level
//        case netWorth = "net_worth"
//        case aghanimsScepter = "aghanims_scepter"
//        case aghanimsShard = "aghanims_shard"
//        case moonshard
//        case heroDamage = "hero_damage"
//        case towerDamage = "tower_damage"
//        case heroHealing = "hero_healing"
//        case gold
//        case goldSpent = "gold_spent"
//        case scaledHeroDamage = "scaled_hero_damage"
//        case scaledTowerDamage = "scaled_tower_damage"
//        case scaledHeroHealing = "scaled_hero_healing"
//        case abilityUpgrades = "ability_upgrades"
//        case additionalUnits = "additional_units"
//    }
//}
//
//// MARK: - AbilityUpgrade
//struct AbilityUpgrade: Codable {
//    let ability, time, level: Int
//}
//
//// MARK: - AdditionalUnit
//struct AdditionalUnit: Codable {
//    let unitname: String
//    let item0, item1, item2, item3: Int
//    let item4, item5, backpack0, backpack1: Int
//    let backpack2, itemNeutral: Int
//
//    enum CodingKeys: String, CodingKey {
//        case unitname
//        case item0 = "item_0"
//        case item1 = "item_1"
//        case item2 = "item_2"
//        case item3 = "item_3"
//        case item4 = "item_4"
//        case item5 = "item_5"
//        case backpack0 = "backpack_0"
//        case backpack1 = "backpack_1"
//        case backpack2 = "backpack_2"
//        case itemNeutral = "item_neutral"
//    }
//}
