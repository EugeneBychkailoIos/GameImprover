//
//  CS2StatsViewModel.swift
//  GameImprover
//
//  Created by jekster on 24.01.2025.
//

import Foundation

class CS2StatsViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    
    @Published var lastMatches: [String] = []
    
    private let key: String = "12D2701F45A45E9E773F2293FCCA5685"
    private let id: String = "76561199562083135"
    
    @MainActor
    func getCS2Matches() async {
        self.isLoading = true
        do {
            var tasks: [Task<(String, [Playerstats]), Error>] = []
            
            for matchID in lastMatches {
                let task = Task<(String, [Playerstats]), Error> {
                    do {
                        let userRecords = try await ServiceContainer.shared.apiService.getUserAllRecords(key: key, id: id)
                        self.isLoading = false
                        return (matchID, userRecords)
                    } catch {
                        self.isLoading = false
                        print("Error fetching match data for \(matchID): \(error)")
                        throw error
                    }
                }
                
                tasks.append(task)
            }
        }
    }
}
