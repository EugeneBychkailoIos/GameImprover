//
//  StatsView.swift
//  GameImprover
//
//  Created by jekster on 11.10.2024.
//

import SwiftUI

struct StatsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var title: String
    
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
                
                BaseText(text: title, font: Fonts.jersey25, foregroundColor: Colors.ancestralWater)
            }
            .navigationBarItems(leading: btnBack)
            .navigationBarBackButtonHidden(true)
        }
        .navigationBarBackButtonHidden(true)
    }
}
