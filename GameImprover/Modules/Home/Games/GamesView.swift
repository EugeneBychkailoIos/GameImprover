//
//  GamesView.swift
//  GameImprover
//
//  Created by jekster on 11.10.2024.
//

import SwiftUI

struct GamesView: View {
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Colors.obsidianShard.opacity(0.8),
                                                           Colors.obsidianShard]),
                               startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                Text("Tab 1 Content")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            .navigationBarTitle("Tab 1", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
        }
    }
}
