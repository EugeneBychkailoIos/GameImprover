//
//  NotificationsView.swift
//  GameImprover
//
//  Created by jekster on 25.10.2024.
//

import SwiftUI
import Combine

class NotificationsSettings: ObservableObject {
    @Published var notificationsEnabled: Bool {
        didSet {
            userDefaultsService.setNotificationsEnabled(notificationsEnabled)
        }
    }
    
    private let userDefaultsService: UserDefaultsService
    
    init(userDefaultsService: UserDefaultsService = UserDefaultsService()) {
        self.userDefaultsService = userDefaultsService
        self.notificationsEnabled = userDefaultsService.getNotificationsEnabled()
    }
}



struct NotificationsView: View {
    @EnvironmentObject var notificationsSettings: NotificationsSettings
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
            
            VStack {
                Toggle(isOn: $notificationsSettings.notificationsEnabled) {
                    BaseText(text: "Notifications",
                             font: Fonts.jersey10small,
                             foregroundColor: Colors.ancestralWater
                    )
                }
                .toggleStyle(SwitchToggleStyle(tint: Colors.ancestralWater))
                Spacer()
            }
            .padding([.leading, .trailing, .top], 36)
        }
        .navigationBarItems(leading: btnBack)
        .navigationBarBackButtonHidden(true)
    }
}
