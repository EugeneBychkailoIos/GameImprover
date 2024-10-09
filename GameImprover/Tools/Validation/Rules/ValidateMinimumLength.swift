//
//  ValidateMinimumLength.swift
//  GameImprover
//
//  Created by jekster on 09.10.2024.
//

import UIKit

struct ValidateMinimumLength: ValidationRule {
    
    // MARK: Public methods
    
    func validate(_ input: String?) -> Error? {
        guard let input = input?.trimmingCharacters(in: .whitespaces),
              !input.isEmpty else {
            return ValidationEmptyError(error: emptyStringError)
        }
        guard let regex = try? NSRegularExpression(pattern: regex) else {
            return ValidationErrorInvalidPattern()
        }
        guard regex.matches(input) else {
            return ValidateMinimumLength.ValidationError(minimumLength: minimumLength)
        }
        return nil
    }
    
    // MARK: Private properties
    
    var regex: String {
        "(?=.{\(minimumLength),})"
    }
    
    // MARK: Nested Types
    
    struct ValidationError: LocalizedError {
        
        // MARK: - Public properties
        
        var errorDescription: String? {
            return "Use \(minimumLength) characters without spaces or more for your password."
        }
        
        let minimumLength: Int
    }
    
    // MARK: Public properties
    
    let minimumLength: Int
    let emptyStringError: String?
}
