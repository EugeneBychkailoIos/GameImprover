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
