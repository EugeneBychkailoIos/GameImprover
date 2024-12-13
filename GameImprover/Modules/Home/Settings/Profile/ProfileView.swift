//
//  ProfileView.swift
//  GameImprover
//
//  Created by jekster on 25.10.2024.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
            
            Text("Profile View")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .navigationBarItems(leading: btnBack)
        .navigationBarBackButtonHidden(true)
    }
}
