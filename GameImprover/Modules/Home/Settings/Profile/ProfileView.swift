//
//  ProfileView.swift
//  GameImprover
//
//  Created by jekster on 25.10.2024.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var viewModel = ProfileViewModel()
    @StateObject private var imageService = ImageService()
    
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
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Colors.obsidianShard.opacity(0.8), Colors.obsidianShard]),
                                   startPoint: .top,
                                   endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)

                    VStack {
                        Spacer()

                        if viewModel.errorMessage != nil {
                            Text("Error: \(viewModel.errorMessage ?? "")")
                                .foregroundColor(.red)
                        } else if viewModel.userNickName.isEmpty {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Colors.ancestralWater))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .controlSize(.large)
                        } else {
                            VStack {
                                HStack {
                                    BaseText(text: viewModel.userNickName, font: Fonts.jersey25, foregroundColor: Colors.ancestralWater)
                                    Spacer()
                                 
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

                                BaseText(text: viewModel.steamId, font: Fonts.jersey25, foregroundColor: Colors.ancestralWater)
                                
                                BaseText(text: "\(viewModel.lastLogoff)", font: Fonts.jersey25, foregroundColor: Colors.ancestralWater)
                                
                                BaseText(text: "\(viewModel.timeCreated)", font: Fonts.jersey25, foregroundColor: Colors.ancestralWater)
                                
                                BaseText(text: "\(viewModel.personState)", font: Fonts.jersey25, foregroundColor: Colors.ancestralWater)
                                
                                BaseText(text: "\(viewModel.profileState)", font: Fonts.jersey25, foregroundColor: Colors.ancestralWater)
                                
                                BaseText(text: viewModel.profileUrl, font: Fonts.jersey25, foregroundColor: Colors.ancestralWater)

                            }
                            .padding(.bottom, 20)
                        }

                        Spacer()
                    }
                    .navigationBarBackButtonHidden(true)
                    .onAppear {
                        Task {
                            try await viewModel.getUserInfo()
                        }
                    }
                }
            }
            .navigationBarItems(leading: btnBack)
            .navigationBarBackButtonHidden(true)
        }
    }
}
