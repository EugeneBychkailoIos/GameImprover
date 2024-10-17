//
//  HomeView.swift
//  GameImprover
//
//  Created by jekster on 11.10.2024.
//

import SwiftUI

struct game {
    let name: String
}

struct HomeView: View {
    
    let viewModel: HomeViewModel = HomeViewModel()
    
    @State var gamesArray: [game] = [game(name:"Dota 2"), game(name:"CS 2")]

    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Colors.obsidianShard.opacity(0.8), Colors.obsidianShard]),
                                   startPoint: .top,
                                   endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        HStack {
                            Spacer()
                            NavigationLink(destination: SettingsView()) {
                                Image("settingsIcon")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(Colors.ancestralWater)
                                    .frame(width: 24, height: 24)
                            }
                            
                            
                        }
                        .padding([.top, .trailing, .bottom], 30)
                        
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.flexible())], spacing: 16) {
                                ForEach(0..<gamesArray.count, id: \.self) { index in
                                    NavigationLink(destination: StatsView(title: gamesArray[index].name)) {
                                        GameCellView(title: gamesArray[index].name)
                                            .frame(width: geometry.size.width, height: 64)
                                    }
                                }
                            }
                            .padding(.horizontal, 18)
                        }
                    }
                    .navigationBarBackButtonHidden(true)
                    .onAppear {
                        viewModel.getUserInfo()
                    }
                }
            }
        }
    }
}


struct GameCellView: View {
    var title: String

    var body: some View {
        VStack {
            BaseText(text: title, font: Fonts.jersey25, foregroundColor: Colors.obsidianShard)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Colors.ancestralWater)
    }
}
