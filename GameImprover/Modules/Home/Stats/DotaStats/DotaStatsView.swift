//
//  DotaStatsView.swift
//  GameImprover
//
//  Created by jekster on 11.10.2024.
//

import SwiftUI
import Combine

struct MatchRowView: View {
    var heroID: Int
    var heroName: String
    var matchStats: PlayerMatchStats
    var heroImage: Image
    var match: MatchDetailModel
    
    var body: some View {
        NavigationLink(destination: MatchDetailView(match: match)) {
            MapStatisticView(
                heroID: heroID,
                heroName: heroName,
                winOrLose: matchStats.didWin,
                kills: matchStats.kills,
                deaths: matchStats.deaths,
                assists: matchStats.assists,
                duration: matchStats.duration, 
                heroImage: heroImage
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}



struct DotaStatsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject private var viewModel = DotaStatsViewModel()
    
    var btnBack: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                BaseText(text: "Go Back", font: Fonts.jersey25, foregroundColor: Colors.ancestralWater)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Colors.obsidianShard.opacity(0.8), Colors.obsidianShard]),
                               startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                GeometryReader { geometry in
                    VStack {
                        if viewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Colors.ancestralWater))
                                .scaleEffect(2)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        } else {
                            ScrollView {
                                VStack(spacing: 0) {
                                    ForEach(0..<viewModel.playerAndMatchStats.count, id: \.self) { index in
                                        let matchStats = viewModel.playerAndMatchStats[index]
                                        let allMatch = viewModel.allMatchStats[safe: index]
                                        
                                        let heroID = matchStats.heroId
                                        let heroImage = viewModel.loadedheroImages[heroID] ?? Image(systemName: "star.fill")
                                        let heroName = viewModel.loadedHeroNames[heroID] ?? "Unknown Hero"
                                        
                                        if let allMatch = allMatch {

                                            MatchRowView(
                                                heroID: heroID,
                                                heroName: heroName,
                                                matchStats: matchStats,
                                                heroImage: heroImage,
                                                match: allMatch
                                            )
                                            .background(
                                                        index % 2 == 0 ?
                                                        Colors.obsidianShard.opacity(0.5) :
                                                        Colors.obsidianShard.opacity(0.9)
                                                    )
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarItems(leading: btnBack)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                Task {
                    await loadData()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func loadData() async {
        viewModel.lastMatches.removeAll()
        viewModel.playerAndMatchStats.removeAll()
        viewModel.lastHeroes.removeAll()
        viewModel.allMatchStats.removeAll()
        
        await viewModel.getDotaMatchBySequence()
        await viewModel.getDotaMatches()
        
        var heroLoadingTasks: [Task<Void, Never>] = []
        for heroID in viewModel.lastHeroes {
            let task = Task {
                await viewModel.loadHeroData(for: heroID)
            }
            heroLoadingTasks.append(task)
        }
        
        await withTaskGroup(of: Void.self) { group in
            for task in heroLoadingTasks {
                group.addTask {
                    await task.value
                }
            }
        }
    }
}


extension Array {
    subscript(safe index: Int) -> Element? {
        return index >= 0 && index < count ? self[index] : nil
    }
}
