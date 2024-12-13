//
//  MatchDetailView.swift
//  GameImprover
//
//  Created by jekster on 24.10.2024.
//

import SwiftUI

struct MatchDetailView: View {
    
    @StateObject private var heroesService = HeroesService()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var match: MatchDetailModel
    
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
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Colors.obsidianShard.opacity(0.8), Colors.obsidianShard]),
                           startPoint: .top,
                           endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical) {
                VStack {
                    ScrollView(.horizontal) {
                        HStack(spacing: 0) {
                            VStack(spacing: 10) {
                                HStack {
                                    BaseText(text: "Radiant", font: Fonts.jersey10small, foregroundColor: Colors.indiaGreen)
                                        .padding(.leading, 16)
                                    Spacer()
                                }
                                
                                DotaStatisticHeaderView()
                                                                
                                ForEach(match.players.filter { $0.isRadiant }, id: \.heroID) { player in
                                    MatchDetailCell(heroesService: heroesService, player: player)
                                }
                                
                                Divider()
                                    .background(Colors.obsidianShard.opacity(0.8))
                                    .padding(.vertical, 5)
                                
                                HStack {
                                    BaseText(text: "Dire", font: Fonts.jersey10small, foregroundColor: Colors.artfulRed)
                                        .padding(.leading, 16)
                                    Spacer()
                                }
                                
                                DotaStatisticHeaderView()
                                
                                ForEach(match.players.filter{!$0.isRadiant}, id: \.heroID) { player in
                                    MatchDetailCell(heroesService: heroesService, player: player)
                                }
                            }
                        }
                    }
                }
                .background(Colors.obsidianShard.opacity(0.8))
            }
        }
        .navigationBarItems(leading: btnBack)
        .navigationBarBackButtonHidden(true)
        .onAppear {

        }
    }
}
