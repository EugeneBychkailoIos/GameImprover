//
//  SteamAuthViewModel.swift
//  GameImprover
//
//  Created by jekster on 08.10.2024.
//

import Foundation
import SwiftUI


class SteamAuthViewModel: ObservableObject {
    @Published var steamID: String?
    @Published var errorMessage: String?
    @Published var isAuthenticated: Bool = false

    func startSteamAuth() {
        guard let url = URL(string: "https://us-central1-gameimprover-3babe.cloudfunctions.net/steamAuth") else { return }
        UIApplication.shared.open(url)
    }

    func handleSteamResponse(url: URL) {
        print("Received URL: \(url.absoluteString)")
        
        let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems
        print("Query Items: \(queryItems ?? [])")
        
        if let modeValue = queryItems?.first(where: { $0.name == "openid.mode" })?.value {
            
            if modeValue == "id_res" {
                if let steamIDValue = queryItems?.first(where: { $0.name == "openid.claimed_id" })?.value {
                    let steamID = extractSteamID(from: steamIDValue)
                    print("Extracted Steam ID: \(steamID ?? "nil")")
                    self.steamID = steamID
                    self.isAuthenticated = true
                    self.errorMessage = nil
                } else {
                    print("Failed to extract Steam ID from claimed_id")
                    self.isAuthenticated = false
                    self.errorMessage = "Failed to extract Steam ID"
                }
            } else {
                self.isAuthenticated = false
                self.errorMessage = "Steam authentication failed due to invalid mode"
            }
        } else {
            print("No openid.mode found in the response")
            self.isAuthenticated = false
            self.errorMessage = "Steam authentication failed due to missing openid.mode"
        }
    }

    func extractSteamID(from openIDClaimedID: String) -> String? {
        if let range = openIDClaimedID.range(of: "id/") {
            let steamIDWithPrefix = String(openIDClaimedID[range.upperBound...])
            let digits = steamIDWithPrefix.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            return digits.isEmpty ? nil : digits
        }
        return nil
    }
}
