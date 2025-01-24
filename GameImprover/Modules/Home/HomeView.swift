//
//  HomeView.swift
//  GameImprover
//
//  Created by jekster on 11.10.2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @StateObject private var imageService = ImageService()

    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Colors.obsidianShard.opacity(0.8), Colors.obsidianShard]),
                                   startPoint: .top,
                                   endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        Spacer()
                        
                        if viewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Colors.ancestralWater))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .controlSize(.large)
                        } else {
                            if let errorMessage = viewModel.errorMessage {
                                Text("Error: \(errorMessage)")
                                    .foregroundColor(.red)
                            } else {
                                VStack {
                                    HStack {
                                        BaseText(text: viewModel.userNickName, font: Fonts.jersey25, foregroundColor: Colors.ancestralWater)
                                        Spacer()
                                        NavigationLink(destination: SettingsView()) {
                                            Image("settingsIcon")
                                                .resizable()
                                                .renderingMode(.template)
                                                .foregroundColor(Colors.ancestralWater)
                                                .frame(width: 24, height: 24)
                                        }
                                    }
                                    .padding([.top, .trailing, .bottom, .leading], 30)
                                    
                                    if let image = imageService.image {
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .clipShape(Circle())
                                            .overlay(
                                                Circle()
                                                    .stroke(Colors.ancestralWater, lineWidth: 2)
                                            )
                                            .frame(width: 70, height: 70)
                                    }
                                }
                                .padding(.bottom, 20)

                                ScrollView {
                                    LazyVGrid(columns: [GridItem(.flexible())], spacing: 16) {
                                        ForEach(viewModel.gamesArray, id: \.self) { game in
                                            NavigationLink(destination: game == "Dota 2" ?
                                                           AnyView(DotaStatsView()) :
                                                           AnyView(CS2StatsView())
                                            ) {
                                                GameCellView(title: game)
                                                    .frame(width: geometry.size.width, height: 64)
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 50)
                                }
                                .frame(maxHeight: .infinity)
                                .padding(.top, 20)
                            }
                        }
                        
                        Spacer()
                    }
                    .navigationBarBackButtonHidden(true)
                    .onAppear {
                        Task {
                            await viewModel.loadUserData()
                            imageService.downloadImage(urlString: viewModel.userAvatarString)
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
