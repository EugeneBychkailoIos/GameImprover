//
//  ActualRank.swift
//  GameImprover
//
//  Created by jekster on 22.10.2024.
//

import SwiftUI

class CSplayerRatingHelper: ObservableObject {
    
    func calculatePlayerRating(kills: Int, deaths: Int, assists: Int, damage: Int, roundsPlayed: Int, headshots: Int, wins: Int, totalMatches: Int, mvps: Int, roundsWon: Int, totalRounds: Int) -> Double {
        
        let kdr = calculateKDR(kills: kills,
                               deaths: deaths)
        let kda = calculateKDA(kills: kills,
                               deaths: deaths,
                               assists: assists)
        let adr = calculateADR(damage: damage, 
                               roundsPlayed: roundsPlayed)
        let hsPercentage = calculateHSPercentage(headshots: headshots,
                                                 kills: kills)
        let winRate = calculateWinRate(wins: wins,
                                       totalMatches: totalMatches)
        let mvpsPerMatch = calculateMVPsPerMatch(mvps: mvps, 
                                                 totalMatches: totalMatches)
        let roundWinRate = calculateRoundWinRate(roundsWon: roundsWon, 
                                                 totalRounds: totalRounds)
        
        let weightedRating = (kdr * 0.30) +
        (kda * 0.25) +
        (adr * 0.20) +
        (hsPercentage * 0.10) +
        (winRate * 0.10) +
        (mvpsPerMatch * 0.05)
        
        let normalizedRating = min(weightedRating, 100.0)
        
        return normalizedRating
    }
    
    
    func calculateKDR(kills: Int, deaths: Int) -> Double {
        guard deaths > 0 else {
            return Double(kills)
        }
        return Double(kills) / Double(deaths)
    }
    
    func calculateKDA(kills: Int, deaths: Int, assists: Int) -> Double {
        guard deaths > 0 else {
            return Double(kills + assists)
        }
        return Double(kills + assists) / Double(deaths)
    }
    
    func calculateADR(damage: Int, roundsPlayed: Int) -> Double {
        guard roundsPlayed > 0 else { return 0 }
        return Double(damage) / Double(roundsPlayed)
    }
    
    func calculateHSPercentage(headshots: Int, kills: Int) -> Double {
        guard kills > 0 else { return 0 }
        return (Double(headshots) / Double(kills)) * 100
    }
    
    
    func calculateWinRate(wins: Int, totalMatches: Int) -> Double {
        guard totalMatches > 0 else { return 0 }
        return (Double(wins) / Double(totalMatches)) * 100
    }
    
    func calculateMVPsPerMatch(mvps: Int, totalMatches: Int) -> Double {
        guard totalMatches > 0 else { return 0 }
        return Double(mvps) / Double(totalMatches)
    }
    
    func calculateRoundWinRate(roundsWon: Int, totalRounds: Int) -> Double {
        guard totalRounds > 0 else { return 0 }
        return (Double(roundsWon) / Double(totalRounds)) * 100
    }
    
}
