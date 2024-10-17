//
//  SteamAuthView.swift
//  GameImprover
//
//  Created by jekster on 08.10.2024.
//

import Foundation
import SwiftUI

struct SteamAuthView: View {
    @StateObject private var viewModel = SteamAuthViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var showWebView = false
    @State private var showSplashScreen = false
    @State private var navigateToSignUp = false
    
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
                LinearGradient(gradient: Gradient(colors: [Colors.obsidianShard.opacity(0.8), Colors.obsidianShard]),
                               startPoint: .top,
                               endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

                VStack {
                    if showWebView {
                        BaseButton(title: "Close",
                                   backgroundColor: Colors.ancestralWater,
                                   textColor: Colors.obsidianShard,
                                   width: 284,
                                   height: 40,
                                   font: Fonts.jersey10small
                        ) {
                            showWebView = false
                        }
                        .padding([.bottom, .top], 12)
                        SteamAuthWebView(viewModel: viewModel, completion: { url in
                            if let url = url {
                                viewModel.handleSteamResponse(url: url)
                            }
                            showWebView = false
                        })
                        .frame(width: UIScreen.main.bounds.width - 40,
                               height: UIScreen.main.bounds.height / 1.35)
                        .cornerRadius(5)
                        .padding(.bottom, 12)
                    } else {
                        if !showSplashScreen {
                            BaseText(text: "Authorize with steam and then, continue sign up in application!", font: Fonts.jersey25,
                                     foregroundColor: Colors.ancestralWater
                            )
                                .padding([.leading, .trailing], 32)
                                .padding(.top, 62)
                            Spacer()
                            BaseButton(image: Image("steamButton"),
                                       width: 180,
                                       height: 35
                            ) {
                                showWebView = true
                            }
                            .padding(.bottom, 64)
                        }
                    }

                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                }
                
                if showSplashScreen {
                    VStack {
                        BaseText(text: "Authorization succesfull!",
                                 font: Fonts.jersey25,
                                 foregroundColor: Colors.ancestralWater
                        )
                        
                    }
                    .edgesIgnoringSafeArea(.all)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            showSplashScreen = false
                            navigateToSignUp = true
                        }
                    }
                    .transition(.opacity)
                }
                
                NavigationLink(destination: SignUpView( steamId: viewModel.steamID ?? ""), isActive: $navigateToSignUp) {
                    EmptyView()
                }
            }
        }
        .onChange(of: viewModel.steamID) { newSteamID in
            if newSteamID != nil {
                showSplashScreen = true
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
    }
}
