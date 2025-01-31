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



// MARK: - Inventory

struct InventoryItem: Identifiable, Codable {
    var id: String
    var name: String
    var type: ItemType
    var rarity: ItemRarity
    var condition: ItemCondition
    var quantity: Int
    var price: Double?
    var imageUrl: String?
    
    enum ItemType: String, Codable {
        case weapon
        case skin
        case caseItem
        case sticker
        case container
        case musicKit
        case graffiti
    }
    
    enum ItemRarity: String, Codable {
        case common
        case uncommon
        case rare
        case veryRare
        case legendary
        case mythic
    }
    
    enum ItemCondition: String, Codable {
        case factoryNew = "Factory New"
        case minimalWear = "Minimal Wear"
        case fieldTested = "Field-Tested"
        case wellWorn = "Well-Worn"
        case battleScarred = "Battle-Scarred"
    }
}

struct UserInventory: Codable {
    var userId: String
    var items: [InventoryItem]
    
    func filterByRarity(_ rarity: InventoryItem.ItemRarity) -> [InventoryItem] {
        return items.filter { $0.rarity == rarity }
    }
    
    func sortByPrice() -> [InventoryItem] {
        return items.sorted { ($0.price ?? 0) > ($1.price ?? 0) }
    }
    
    func filterByType(_ type: InventoryItem.ItemType) -> [InventoryItem] {
        return items.filter { $0.type == type }
    }
}


