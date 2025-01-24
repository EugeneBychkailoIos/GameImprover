//
//  WinCondition.swift
//  GameImprover
//
//  Created by jekster on 13.12.2024.
//

import Foundation

enum WinCondition: String {
    case win
    case lose
    
    var rawValue: String {
        switch self {
        case .win:
            return "Win"
        case .lose:
            return "Lose"
        }
    }
}

func calculateWinRate(wins: Int, totalMatches: Int) -> Double {
    guard totalMatches > 0 else { return 0 }
    return (Double(wins) / Double(totalMatches)) * 100
}
