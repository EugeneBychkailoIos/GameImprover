//
//  ValidationRule.swift
//  GameImprover
//
//  Created by jekster on 09.10.2024.
//

import UIKit

protocol ValidationRule {
    
    /// Method that validate string
    /// If error is nil, string is valid
    func validate(_ input: String?) -> Error?
    
    /// Regex to validate input string
    var regex: String { get }
}

