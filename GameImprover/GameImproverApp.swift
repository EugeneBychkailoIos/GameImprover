//
//  GameImproverApp.swift
//  GameImprover
//
//  Created by jekster on 04.10.2024.
//

import SwiftUI

@main
struct GameImproverApp: App {
        
    @UIApplicationDelegateAdaptor(FirebaseAppDelegate.self) var delegate
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    @StateObject private var appearanceSettings = AppearanceSettings()
    @StateObject private var languageSettings = LanguageSettings()
    @StateObject private var notificationsSettings = NotificationsSettings()
    
    var body: some Scene {
        WindowGroup {
            SplashScreen(isOnboarding: $isOnboarding)
                .environmentObject(appearanceSettings)
                .environmentObject(languageSettings)
                .environmentObject(notificationsSettings)
            
            
//            MapStatisticView(heroID: 2, heroName: "centaur warrunner", winOrLose: true, kills: 1, deaths: 5, assists: 13, duration: 2006)
            
//            SettingsView()
//            AuthorizationView()
//            LanguageView()
        }
    }
}
