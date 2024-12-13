//
//  SettingsView.swift
//  GameImprover
//
//  Created by jekster on 11.10.2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appearanceSettings: AppearanceSettings
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var settingsCellTitles = ["Profile", "Notifications", "Privacy", "Appearance", "Language", "Logout"]
    
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
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Colors.obsidianShard.opacity(0.8),
                                                               Colors.obsidianShard]),
                                   startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                    
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible())], spacing: 16) {
                            ForEach(0..<settingsCellTitles.count, id: \.self) { index in
                                NavigationLink(destination: destinationView(for: index)) {
                                    SettingsCellView(title: settingsCellTitles[index])
                                        .frame(width: geometry.size.width, height: 64)
                                }
                            }
                        }
                        .padding(.horizontal, 18)
                    }
                }
                .navigationBarItems(leading: btnBack)
                .navigationBarBackButtonHidden(true)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
   
    @ViewBuilder
    func destinationView(for index: Int) -> some View {
        switch index {
        case 0:
            ProfileView()
        case 1:
            NotificationsView()
        case 2:
            PrivacyView()
        case 3:
            AppearanceView()
        case 4:
            LanguageView()
        case 5:
            LogoutView()
        default:
            EmptyView()
        }
    }
}
