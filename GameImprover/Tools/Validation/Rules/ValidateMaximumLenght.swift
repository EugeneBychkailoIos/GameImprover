//
//  ValidateMaximumLenght.swift
//  GameImprover
//
//  Created by jekster on 09.10.2024.
//

import Foundation

struct ValidateMaximumLenght: ValidationRule {
    
    // MARK: Public methods
    
    func validate(_ input: String?) -> Error? {
        guard let input = input?.trimmingCharacters(in: .whitespaces) else {
            assertionFailure("input must be not nil")
            return ValidationEmptyError(error: nil)
        }
        guard let regex = try? NSRegularExpression(pattern: regex) else {
            return ValidationErrorInvalidPattern()
        }
        guard regex.matches(input) else {
            return ValidateMaximumLenght.ValidationError(maximumLenght: maximumLenght)
        }
        return nil
    }
    
    // MARK: Private properties
    
    var regex: String {
        "^(?=.{1,\(maximumLenght)}$).*"
    }
    
    // MARK: Nested Types
    
    struct ValidationError: LocalizedError {
        var errorDescription: String? {
            return "Don't use more than \(maximumLenght) characters with spaces for your password."
        }
        
        let maximumLenght: Int
    }
    
    // MARK: Public properties
    
    let maximumLenght: Int
}

