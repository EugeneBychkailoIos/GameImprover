//
//  DotaStatsViewModel.swift
//  GameImprover
//
//  Created by jekster on 11.10.2024.
//

import SwiftUI
import Combine
import FirebaseFirestore
import FirebaseFirestoreCombineSwift

struct PlayerMatchStats: Hashable {
    let duration: Int
    let kills: Int
    let deaths: Int
    let assists: Int
    let isRadiant: Bool
    let radiantWin: Bool
    let heroId: Int
    
    var didWin: Bool {
        if isRadiant {
            return radiantWin
        } else {
            return !radiantWin
        }
    }

    init(duration: Int, kills: Int, deaths: Int, assists: Int, isRadiant: Bool, radiantWin: Bool, heroId: Int) {
        self.duration = duration
        self.kills = kills
        self.deaths = deaths
        self.assists = assists
        self.isRadiant = isRadiant
        self.radiantWin = radiantWin
        self.heroId = heroId
    }
    
    static func == (lhs: PlayerMatchStats, rhs: PlayerMatchStats) -> Bool {
        return lhs.heroId == rhs.heroId &&
               lhs.kills == rhs.kills &&
               lhs.deaths == rhs.deaths &&
               lhs.assists == rhs.assists &&
               lhs.isRadiant == rhs.isRadiant &&
               lhs.radiantWin == rhs.radiantWin &&
               lhs.duration == rhs.duration
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(heroId)
        hasher.combine(kills)
        hasher.combine(deaths)
        hasher.combine(assists)
        hasher.combine(isRadiant)
        hasher.combine(radiantWin)
        hasher.combine(duration)
    }
}




class DotaStatsViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var loadedheroImages: [Int: Image] = [:]
    @Published var loadedHeroNames: [Int: String] = [:]
    
    private let key: String = "12D2701F45A45E9E773F2293FCCA5685"
    private let id: String = "76561199562083135"
    
    private let openKey: String = "caa86e76-602d-4281-b46e-b0e555982a04"
    
    @Published var lastMatches: [String] = []
    
    private var imageService = ImageService()
    private var heroesService = HeroesService()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var matchesInfo: [MatchDetailModel] = []
    
    @Published var playerAndMatchStats: [PlayerMatchStats] = []
    
    @Published var allMatchStats: [MatchDetailModel] = []
    
    @Published var playerSteamId: Int = 0
    
    @Published var lastHeroes: [Int] = []
    
    @MainActor
    func getDotaMatches() async {
        self.isLoading = true
        do {
            var tasks: [Task<(String, [MatchDetailModel]), Error>] = []
            
            for matchID in lastMatches {
                let task = Task<(String, [MatchDetailModel]), Error> {
                    do {
                        let matchData = try await ServiceContainer.shared.apiService.getMatchById(key: openKey, matchId: matchID)
                        return (matchID, matchData)
                    } catch {
                        print("Error fetching match data for \(matchID): \(error)")
                        throw error
                    }
                }
                
                tasks.append(task)
            }
            
            for task in tasks {
                do {
                    let (matchID, matchData) = try await task.value
                    for match in matchData {
                        self.allMatchStats.append(match)
                        for player in match.players {
                            let accountID = player.accountID
                            
                            let targetAccountID = 1601817407
                            
                            if accountID == targetAccountID {
                                let kills = player.kills
                                let deaths = player.deaths
                                let assists = player.assists
                                let isRadiant = player.isRadiant
                                let radiantWin = match.radiantWin
                                let duration = match.duration
                                let heroID = player.heroID
                                
                                let playerStats = PlayerMatchStats(
                                    duration: duration,
                                    kills: kills,
                                    deaths: deaths,
                                    assists: assists,
                                    isRadiant: isRadiant,
                                    radiantWin: radiantWin,
                                    heroId: heroID
                                )
                        
                                playerAndMatchStats.append(playerStats)
                            }
                        }
                    }
                } catch {
                    print("Error with task: \(error)")
                }
            }
            
            for stats in playerAndMatchStats {
                await loadHeroData(for: stats.heroId)
            }

            for player in playerAndMatchStats {
                print("id \(player.heroId), kda \(player.kills) \(player.deaths) \(player.assists), win: \(player.didWin)")
            }
            
            self.isLoading = false
            
        } catch {
            self.isLoading = false
            print("ERROR IS: \(error)")
        }
    }
    
    @MainActor
    func getDotaMatchBySequence() async {
        self.isLoading = true
        do {
            let data = try await ServiceContainer.shared.apiService.getLastMatches(key: key, id: id, matches: 10)
            
            var playerCount = [Int: Int]()
            for match in data {
                for player in match.players {
                    playerCount[player.accountID, default: 0] += 1
                }
            }
            
            let repeatingPlayerId = playerCount.filter { $0.value == 10 }.map { $0.key }

            for match in data {
                for player in match.players {
                    if repeatingPlayerId.contains(player.accountID) {
                        let heroId = player.heroID
                        self.lastMatches.append("\(match.matchID)")
                        self.lastHeroes.append(heroId)
                    }
                }
            }
        } catch {
            self.isLoading = false
            print("ERROR IS: \(error)")
        }
    }
    
    @MainActor
    func loadHeroData(for heroID: Int) async {
        // cache
        if let heroData = heroesService.getHeroData(for: heroID) {
            self.loadedheroImages[heroID] = heroData.image
            self.loadedHeroNames[heroID] = heroData.heroName
        } else {
            // load
            await heroesService.downloadHeroData(heroID: heroID)
            if let heroData = heroesService.getHeroData(for: heroID) {
                self.loadedheroImages[heroID] = heroData.image
                self.loadedHeroNames[heroID] = heroData.heroName
                print("Loaded hero \(heroData.heroName) after downloading.")
            }
        }
    }
}




