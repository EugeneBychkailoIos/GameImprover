//
//  HomeViewModel.swift
//  GameImprover
//
//  Created by jekster on 11.10.2024.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    
    func getUserInfo() {
        ServiceContainer.shared.apiService.getUserInfo(key: "12D2701F45A45E9E773F2293FCCA5685", id: "76561199562083135") { [weak self]  result in
            switch result {
            case .success(let data):
                print("Data is: \(data)")
                
            case .failure(let error):
                print("ERROR IS: \(error)")
                
            }
        }
    }
    
    
}
