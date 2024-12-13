//
//  KDA.swift
//  GameImprover
//
//  Created by jekster on 22.10.2024.
//

import Foundation

struct KDA {
    let kills: Int
    let deaths: Int
    let assists: Int
    
    var total: Int {
        return kills + deaths + assists
    }
    
    var killsPercentage: CGFloat {
        return total > 0 ? CGFloat(kills) / CGFloat(total) : 0
    }
    
    var deathsPercentage: CGFloat {
        return total > 0 ? CGFloat(deaths) / CGFloat(total) : 0
    }
    
    var assistsPercentage: CGFloat {
        return total > 0 ? CGFloat(assists) / CGFloat(total) : 0
    }
}
