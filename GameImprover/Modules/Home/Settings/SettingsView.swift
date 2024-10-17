//
//  SettingsView.swift
//  GameImprover
//
//  Created by jekster on 11.10.2024.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var cellTitles = ["Profile", "Notifications", "Privacy", "Security", "Appearance", "Language", "Logout"]
    
    
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
                    LinearGradient(gradient: Gradient(colors: [Colors.obsidianShard.opacity(0.8),
                                                               Colors.obsidianShard]),
                                   startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                    
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible())], spacing: 16) {
                            ForEach(0..<cellTitles.count, id: \.self) { index in
                                NavigationLink(destination: destinationView(for: index)) {
                                    CellView(title: cellTitles[index])
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
            SecurityView()
        case 4:
            AppearanceView()
        case 5:
            LanguageView()
        case 6:
            LogoutView()
        default:
            DetailView(title: "Unknown")
        }
    }
}

struct CellView: View {
    var title: String

    var body: some View {
        VStack {
            BaseText(text: title,
                     font: Fonts.jersey25,
                     foregroundColor: Colors.obsidianShard
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Colors.ancestralWater)
    }
}


struct ProfileView: View {
    var body: some View {
        ZStack {
            Color.green.edgesIgnoringSafeArea(.all)
            Text("Profile View")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .navigationBarTitle("Profile", displayMode: .inline)
    }
}

struct NotificationsView: View {
    var body: some View {
        ZStack {
            Color.orange.edgesIgnoringSafeArea(.all)
            Text("Notifications View")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .navigationBarTitle("Notifications", displayMode: .inline)
    }
}

struct PrivacyView: View {
    var body: some View {
        ZStack {
            Color.purple.edgesIgnoringSafeArea(.all)
            Text("Privacy View")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .navigationBarTitle("Privacy", displayMode: .inline)
    }
}

struct SecurityView: View {
    var body: some View {
        ZStack {
            Color.red.edgesIgnoringSafeArea(.all)
            Text("Security View")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .navigationBarTitle("Security", displayMode: .inline)
    }
}

struct AppearanceView: View {
    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)
            Text("Appearance View")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .navigationBarTitle("Appearance", displayMode: .inline)
    }
}

struct LanguageView: View {
    var body: some View {
        ZStack {
            Color.yellow.edgesIgnoringSafeArea(.all)
            Text("Language View")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .navigationBarTitle("Language", displayMode: .inline)
    }
}

struct LogoutView: View {
    var body: some View {
        ZStack {
            Color.gray.edgesIgnoringSafeArea(.all)
            Text("You have been logged out.")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .navigationBarTitle("Logout", displayMode: .inline)
    }
}

struct DetailView: View {
    var title: String

    var body: some View {
        ZStack {
            Color.gray.edgesIgnoringSafeArea(.all)
            Text("This is the \(title) screen")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .navigationBarTitle(title, displayMode: .inline)
    }
}
