//
//  ValidationEmptyError.swift
//  GameImprover
//
//  Created by jekster on 09.10.2024.
//

import Foundation

struct ValidationEmptyError: LocalizedError {
    
    // MARK: - Public properties
    
    var errorDescription: String? {
        return error
    }
    
    // MARK: - Private properties
    
    private let error: String?
    
    // MARK: - Init
    
    init(error: String?) {
        self.error = error
    }
}
