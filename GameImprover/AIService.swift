//
//  AIService.swift
//  GameImprover
//
//  Created by jekster on 31.01.2025.
//

import Foundation


class OpenDotaAPI {
    static let shared = OpenDotaAPI()

    func fetchRecentMatches(accountId: Int, completion: @escaping ([AIMatchModel]) -> Void) {
        let urlString = "https://api.opendota.com/api/players/\(accountId)/matches?limit=10"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching recent matches: \(error)")
                completion([])
                return
            }

            guard let data = data else {
                print("No data received")
                completion([])
                return
            }

            do {
                let matches = try JSONDecoder().decode([AIMatchModel].self, from: data)
                completion(matches)
            } catch {
                print("Error decoding matches data: \(error)")
                completion([])
            }
        }.resume()
    }

    func fetchMatchStats(matchId: Int, completion: @escaping (AIMatchStats?) -> Void) {
        let urlString = "https://api.opendota.com/api/matches/\(matchId)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching match stats: \(error)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }

            do {
                let matchStats = try JSONDecoder().decode(AIMatchStats.self, from: data)
                completion(matchStats)
            } catch {
                print("Error decoding match stats: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
