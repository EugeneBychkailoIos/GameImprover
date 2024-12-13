//
//  UserDefaultsService.swift
//  GameImprover
//
//  Created by jekster on 09.10.2024.
//

import Foundation

class UserDefaultsService {
    private let selectedLanguageKey = "selectedLanguageIndex"
    private let selectedAppearanceKey = "selectedAppearanceIndex"
    private let notificationsEnabledKey = "notificationsEnabled"

    func getSelectedLanguageIndex() -> Int {
        return UserDefaults.standard.integer(forKey: selectedLanguageKey)
    }

    func setSelectedLanguageIndex(_ index: Int) {
        UserDefaults.standard.set(index, forKey: selectedLanguageKey)
    }
    
    func getSelectedAppearanceIndex() -> Int {
        return UserDefaults.standard.integer(forKey: selectedAppearanceKey)
    }

    func setSelectedAppearanceIndex(_ index: Int) {
        UserDefaults.standard.set(index, forKey: selectedAppearanceKey)
    }

    func getNotificationsEnabled() -> Bool {
        return UserDefaults.standard.bool(forKey: notificationsEnabledKey)
    }

    func setNotificationsEnabled(_ enabled: Bool) {
        UserDefaults.standard.set(enabled, forKey: notificationsEnabledKey)
    }
}
