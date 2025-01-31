//
//  CS2StatsView.swift
//  GameImprover
//
//  Created by jekster on 24.10.2024.
//

import SwiftUI

// Основний вигляд для статистики
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
                         foregroundColor: Colors.ancestralWater)
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
                                LazyVStack {
                                    ForEach(0..<10, id: \.self) { _ in
                                                                       CS2RecordCell(name: "name", value: "value")
                                            .transition(.move(edge: .bottom))
                                    }
                                }
                                .padding(.top, 10)
                            }
                        }
                    }
                }
                .onAppear {
                    Task {
                        await viewModel.getCS2Matches()
                    }
                }
            }
            .navigationBarItems(leading: btnBack)
            .navigationBarBackButtonHidden(true)
        }
    }
}

// Оновлена "Record" клітинка з анімацією і стилями
struct CS2RecordCell: View {
    var name: String
    var value: String
    
    @State private var isPressed = false
    
    var body: some View {
        VStack {
            HStack {
                BaseText(text: name,
                         font: Fonts.jersey10small,
                         foregroundColor: Colors.ancestralWater)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                Spacer()
                BaseText(text: value,
                         font: Fonts.jersey10small,
                         foregroundColor: Colors.ancestralWater)
                    .padding(.trailing, 20)
            }
            .padding()
            .background(isPressed ? Colors.ancestralWater.opacity(0.2) : Color.clear)
            .cornerRadius(12)
            .shadow(color: Colors.ancestralWater.opacity(0.1), radius: 5, x: 0, y: 5)
            .scaleEffect(isPressed ? 0.98 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: isPressed)
            .onTapGesture {
                withAnimation {
                    isPressed.toggle()
                }
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .transition(.scale)
    }
}

struct StatsCell: View {
    var title: String
    var value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                BaseText(text: title, font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
                Spacer()
                BaseText(text: value, font: Fonts.jersey10small, foregroundColor: Colors.ancestralWater)
            }
            .padding(.horizontal, 20)
            .background(Colors.ancestralWater.opacity(0.1))
            .cornerRadius(10)
            .shadow(radius: 3)
        }
        .padding(.vertical, 5)
    }
}

struct MatchSummaryCell: View {
    var matchesPlayed: String
    var wins: String
    var losses: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            StatsCell(title: "Matches Played:", value: matchesPlayed)
            StatsCell(title: "Wins:", value: wins)
            StatsCell(title: "Losses:", value: losses)
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
}

struct KillsDeathsCell: View {
    var kills: String
    var deaths: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            StatsCell(title: "Kills:", value: kills)
            StatsCell(title: "Deaths:", value: deaths)
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
}

struct AccuracyCell: View {
    var accuracy: String
    
    var body: some View {
        StatsCell(title: "Accuracy:", value: accuracy)
            .padding(.top, 10)
    }
}

struct ScoreCell: View {
    var score: String
    
    var body: some View {
        StatsCell(title: "Score:", value: score)
            .padding(.top, 10)
    }
}

struct WeaponStatsCell: View {
    var weaponName: String
    var kills: String
    var headshots: String
    var damage: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            StatsCell(title: "Weapon:", value: weaponName)
            StatsCell(title: "Kills:", value: kills)
            StatsCell(title: "Headshots:", value: headshots)
            StatsCell(title: "Damage:", value: damage)
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
}

