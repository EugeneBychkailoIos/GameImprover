//
//  CS2StatsView.swift
//  GameImprover
//
//  Created by jekster on 24.10.2024.
//

import SwiftUI

struct CS2StatsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject private var viewModel = CS2StatsViewModel()
    
    var btnBack: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                BaseText(text: "Go Back",
                         font: Fonts.jersey25,
                         foregroundColor: Colors.ancestralWater
                )
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Colors.obsidianShard.opacity(0.8),
                                                           Colors.obsidianShard]),
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
                                ForEach(0..<10, id: \.self) { _ in
                                    CS2RecordCell(name: "name", value: "value")
                                }
                                
                            }
                        }
                        
                    }
                }
                .navigationBarBackButtonHidden(true)
                .onAppear {
                    Task {
                        await viewModel.getCS2Matches()
                    }
                }
            }
            .navigationBarItems(leading: btnBack)
            .navigationBarBackButtonHidden(true)
        }
        .navigationBarBackButtonHidden(true)
    }
}



struct CS2RecordCell: View {
    var name: String
    var value: String
    
    var body: some View {
        VStack {
            BaseText(text: name,
                     font: Fonts.jersey10small,
                     foregroundColor: Colors.ancestralWater
            )
            BaseText(text: value,
                     font: Fonts.jersey10small,
                     foregroundColor: Colors.ancestralWater
            )
        }
    }
}


// should move to another views:


struct MatchSummaryCell: View {
    var matchesPlayed: String
    var wins: String
    var losses: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                BaseText(text: "Matches Played:", font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                Spacer()
                BaseText(text: matchesPlayed, font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
            }
            HStack {
                BaseText(text: "Wins:", font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                Spacer()
                BaseText(text: wins, font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
            }
            HStack {
                BaseText(text: "Losses:", font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                Spacer()
                BaseText(text: losses, font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
            }
        }
        .padding(.horizontal, 20)
    }
}


struct KillsDeathsCell: View {
    var kills: String
    var deaths: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                BaseText(text: "Kills:", font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                Spacer()
                BaseText(text: kills, font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
            }
            HStack {
                BaseText(text: "Deaths:", font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                Spacer()
                BaseText(text: deaths, font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
            }
        }
        .padding(.horizontal, 20)
    }
}


struct AccuracyCell: View {
    var accuracy: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                BaseText(text: "Accuracy:", font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                Spacer()
                BaseText(text: accuracy, font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
            }
        }
        .padding(.horizontal, 20)
    }
}




struct ScoreCell: View {
    var score: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                BaseText(text: "Score:", font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                Spacer()
                BaseText(text: score, font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
            }
        }
        .padding(.horizontal, 20)
    }
}



struct WeaponStatsCell: View {
    var weaponName: String
    var kills: String
    var headshots: String
    var damage: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                BaseText(text: "Weapon: \(weaponName)", font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
            }
            HStack {
                BaseText(text: "Kills:", font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                Spacer()
                BaseText(text: kills, font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
            }
            HStack {
                BaseText(text: "Headshots:", font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                Spacer()
                BaseText(text: headshots, font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
            }
            HStack {
                BaseText(text: "Damage:", font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                Spacer()
                BaseText(text: damage, font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
            }
        }
        .padding(.horizontal, 20)
    }
}

