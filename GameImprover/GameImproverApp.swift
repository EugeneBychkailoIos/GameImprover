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

    var body: some Scene {
        WindowGroup {
//            SplashScreen(isOnboarding: $isOnboarding)
            BounceAnimationView()
        }
    }
}
