//
//  FirebaseHelper.swift
//  GameImprover
//
//  Created by jekster on 07.10.2024.
//

import Foundation
import FirebaseCore
import UIKit

class FirebaseAppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
    
    
    func application(_ app: UIApplication, 
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return true
    }
}



class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, 
               openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        print("URL received in SceneDelegate:", url)
        if url.scheme == "gameimprover" {
            print("Correct scheme detected in SceneDelegate:", url)
        }
    }
}
